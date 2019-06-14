function EKFSLAM
close all; clear all;
global xVehicleTrue;global Map;global RTrue;global UTrue;global nSteps;
global SensorSettings;

%change these to alter sensor behaviour
SensorSettings.FieldOfView = 45;
SensorSettings.Range = 100;

%how often shall we draw?
DrawEveryNFrames = 50;

%length of experiment
nSteps = 8000;


%when to take pictures?
SnapShots = ceil(linspace(2,nSteps,25));


%size of problem
nFeatures = 40;
MapSize = 200;
Map = MapSize*rand(2,nFeatures)-MapSize/2;

UTrue = diag([0.01,0.01,1.5*pi/180]).^2;
RTrue = diag([1.1,5*pi/180]).^2;

UEst = 2.0*UTrue;
REst = 2.0*RTrue;

xVehicleTrue = [0;0;-pi/2];

%initial conditions - no map:
xEst =[xVehicleTrue];
PEst = diag([1,1,0.01]);
MappedFeatures = NaN*zeros(nFeatures,2);

%storage:
PStore = NaN*zeros(nFeatures,nSteps);
XErrStore = NaN*zeros(nFeatures,nSteps);


%initial graphics - plot true map
figure(1); hold on; grid off; axis equal;
plot(Map(1,:),Map(2,:),'g*');hold on;
set(gcf,'doublebuffer','on');
hObsLine = line([0,0],[0,0]);
set(hObsLine,'linestyle',':');
a = axis; axis(a*1.1);


xOdomLast = GetOdometry(1);

for k = 2:nSteps
    
    %do world iteration
    SimulateWorld(k);
    
    %figure out control
    xOdomNow = GetOdometry(k);
    u = tcomp(tinv(xOdomLast),xOdomNow);
    xOdomLast = xOdomNow;
    
    %we'll need this lots...
    xVehicle = xEst(1:3);
    xMap = xEst(4:end);
    
    %do prediction (the following is simply the result of multiplying 
    %out block form of jacobians)     
    xVehiclePred = tcomp(xVehicle,u);
    PPredvv = J1(xVehicle,u)* PEst(1:3,1:3) *J1(xVehicle,u)' + J2(xVehicle,u)* UEst * J2(xVehicle,u)';
    PPredvm = J1(xVehicle,u)*PEst(1:3,4:end);
    PPredmm = PEst(4:end,4:end);
    
    xPred = [xVehiclePred;xMap];
    PPred = [PPredvv PPredvm;
        PPredvm' PPredmm];
    
    %observe a randomn feature
    [z,iFeature] = GetObservation(k);
    
    if(~isempty(z))
        %have we seen this feature before?
        if( ~isnan(MappedFeatures(iFeature,1)))
            
            %predict observation: find out where it is in state vector
            FeatureIndex = MappedFeatures(iFeature,1);
            xFeature = xPred(FeatureIndex:FeatureIndex+1);
            
            zPred = DoObservationModel(xVehicle,xFeature);
            
            % get observation Jacobians
            [jHxv,jHxf] = GetObsJacs(xVehicle,xFeature);
            
            % fill in state jacobian
            jH = zeros(2,length(xEst));
            jH(:,FeatureIndex:FeatureIndex+1) = jHxf;
            jH(:,1:3) = jHxv;
            
            %do Kalman update:
            Innov = z-zPred;
            Innov(2) = AngleWrap(Innov(2));
            
            S = jH*PPred*jH'+REst;
            W = PPred*jH'*inv(S);
            xEst = xPred+ W*Innov;
            
            PEst = PPred-W*S*W';
            
            %ensure P remains symmetric
            PEst = 0.5*(PEst+PEst');
        else
            % this is a new feature add it to the map....            
            nStates = length(xEst); 
            
            xFeature = xVehicle(1:2)+ [z(1)*cos(z(2)+xVehicle(3));z(1)*sin(z(2)+xVehicle(3))];
            xEst = [xEst;xFeature]; %augmenting state vector
            [jGxv, jGz] = GetNewFeatureJacs(xVehicle,z);
            
            M = [eye(nStates), zeros(nStates,2);% note we don't use jacobian w.r.t vehicle
                jGxv zeros(2,nStates-3)  , jGz];
            
            PEst = M*blkdiag(PEst,REst)*M';
            
            %remember this feature as being mapped we store its ID and position in the state vector
            MappedFeatures(iFeature,:) = [length(xEst)-1, length(xEst)];
            
        end;
    else
        xEst = xPred;
        PESt = PPred;
    end;
    
    
    if(mod(k-2,DrawEveryNFrames)==0)
        a = axis;
        clf;
        axis(a);hold on;
        n  = length(xEst);
        nF = (n-3)/2;
        DoVehicleGraphics(xEst(1:3),PEst(1:3,1:3),3,[0 1]);
        
        if(~isnan(z))
            h = line([xEst(1),xFeature(1)],[xEst(2),xFeature(2)]);
            set(h,'linestyle',':');
        end;               
        for(i = 1:nF)
            iF = 3+2*i-1;
            plot(xEst(iF),xEst(iF+1),'b*');
            PlotEllipse(xEst(iF:iF+1),PEst(iF:iF+1,iF:iF+1),3);
        end;        
        fprintf('k = %d\n',k);        
        drawnow;                
    end;            
    
    if(ismember(k,SnapShots))
        iPic = find(SnapShots==k);
        print(gcf,'-depsc',sprintf('EKFSLAM%d.eps',iPic));    
    end;
    
    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z,iFeature] = GetObservation(k)
global Map;global xVehicleTrue;global RTrue;global nSteps;global SensorSettings
done = 0;
Trys = 1;
z =[];iFeature = -1;
while(~done & Trys <0.5*size(Map,2))
  
    %choose a random feature to see from True Map
    iFeature = ceil(size(Map,2)*rand(1));
    z = DoObservationModel(xVehicleTrue,Map(:,iFeature))+sqrt(RTrue)*randn(2,1);
    z(2) = AngleWrap(z(2));
    %look forward...and only up to 40m
    if(abs(pi/2-z(2))<SensorSettings.FieldOfView*pi/180 & z(1) < SensorSettings.Range)
        done =1 ;
    else
        Trys =Trys+1;
        z =[];iFeature = -1;
    end;
end;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z] = DoObservationModel(xVeh, xFeature)
Delta = xFeature-xVeh(1:2);
z = [norm(Delta);
    atan2(Delta(2),Delta(1))-xVeh(3)];
z(2) = AngleWrap(z(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SimulateWorld(k)
global xVehicleTrue;
u = GetRobotControl(k);
xVehicleTrue = tcomp(xVehicleTrue,u);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [jHxv,jHxf] = GetObsJacs(xPred, xFeature)
jHxv = zeros(2,3);jHxf = zeros(2,2);
Delta = (xFeature-xPred(1:2));
r = norm(Delta);
jHxv(1,1) = -Delta(1) / r;
jHxv(1,2) = -Delta(2) / r;
jHxv(2,1) = Delta(2) / (r^2);
jHxv(2,2) = -Delta(1) / (r^2);
jHxv(2,3) = -1;
jHxf(1:2,1:2) = -jHxv(1:2,1:2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [jGx,jGz] = GetNewFeatureJacs(Xv, z);
x = Xv(1,1);
y = Xv(2,1);
theta = Xv(3,1);
r = z(1);
bearing = z(2);
jGx = [ 1   0   -r*sin(theta + bearing);
    0   1   r*cos(theta + bearing)];
jGz = [ cos(theta + bearing) -r*sin(theta + bearing);
    sin(theta + bearing) r*cos(theta + bearing)];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xnow] = GetOdometry(k)
persistent LastOdom; %internal to robot low-level controller
global UTrue;
if(isempty(LastOdom))
    global xVehicleTrue;
    LastOdom = xVehicleTrue;
end;
u = GetRobotControl(k);
xnow =tcomp(LastOdom,u);
uNoise = sqrt(UTrue)*randn(3,1);
xnow = tcomp(xnow,uNoise);
LastOdom = xnow;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u = GetRobotControl(k)
global nSteps;
%u = [0; 0.25 ; 0.3*pi/180*sin(3*pi*k/nSteps)];
u = [0; 0.15 ; 0.2*pi/180];

%-------- Drawing Covariance -----%
function eH = PlotEllipse(x,P,nSigma)
eH = [];
P = P(1:2,1:2); % only plot x-y part
x = x(1:2);
if(~any(diag(P)==0))
    [V,D] = eig(P);
    y = nSigma*[cos(0:0.1:2*pi);sin(0:0.1:2*pi)];
    el = V*sqrtm(D)*y;
    el = [el el(:,1)]+repmat(x,1,size(el,2)+1);
    eH = line(el(1,:),el(2,:) );
end;