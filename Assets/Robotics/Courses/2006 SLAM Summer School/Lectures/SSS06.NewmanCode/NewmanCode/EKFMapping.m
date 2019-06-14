function EKFLocalisation
close all; clear all;
global xVehicleTrue;global Map;global RTrue;global UTrue;global nSteps;


nSteps = 600;
nFeatures = 6;
MapSize = 200;
Map = MapSize*rand(2,nFeatures)-MapSize/2;

UTrue = diag([0.01,0.01,1*pi/180]).^2;
RTrue = diag([8.0,7*pi/180]).^2;

UEst = 1.0*UTrue;
REst = 1.0*RTrue;

xVehicleTrue = [1;-40;-pi/2];

%initial conditions - no map:
xEst =[];
PEst = [];
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



for k = 2:nSteps
    
    %do world iteration
    SimulateWorld(k);
    
    %simple prediction model:
    xPred = xEst;
    PPred = PEst;
          
    %observe a randomn feature
    [z,iFeature] = GetObservation(k);
    
    if(~isempty(z))
        
        %have we seen this feature before?
        if( ~isnan(MappedFeatures(iFeature,1)))
            
            %predict observation: find out where it is in state vector
            FeatureIndex = MappedFeatures(iFeature,1);
            xFeature = xPred(FeatureIndex:FeatureIndex+1);
            zPred = DoObservationModel(xVehicleTrue,xFeature);
            
            % get observation Jacobians
            [jHxv,jHxf] = GetObsJacs(xVehicleTrue,xFeature);
            
            % fill in state jacobian
            jH = zeros(2,length(xEst));
            jH(:,FeatureIndex:FeatureIndex+1) = jHxf;
            
            %do Kalman update:
            Innov = z-zPred;
            Innov(2) = AngleWrap(Innov(2));
            
            S = jH*PPred*jH'+REst;
            W = PPred*jH'*inv(S);
            xEst = xPred+ W*Innov;
            
            PEst = PPred-W*S*W';
            %note use of 'Joseph' form which is numerically stable
%            I = eye(size(PEst));
%            PEst = (I-W*jH)*PPred*(I-W*jH)'+ W*REst*W';
            
            %ensure P remains symmetric
            PEst = 0.5*(PEst+PEst');
        else
            % this is a new feature add it to the map....            
            nStates = length(xEst); 
            
            xFeature = xVehicleTrue(1:2)+ [z(1)*cos(z(2)+xVehicleTrue(3));z(1)*sin(z(2)+xVehicleTrue(3))];
            xEst = [xEst;xFeature];
            [jGxv, jGz] = GetNewFeatureJacs(xVehicleTrue,z);
            
            M = [eye(nStates), zeros(nStates,2);% note we don't use jacobian w.r.t vehicle
                zeros(2,nStates)  , jGz];
            
            PEst = M*blkdiag(PEst,REst)*M';
            
            %remember this feature as being mapped we store its ID and position in the state vector
            MappedFeatures(iFeature,:) = [length(xEst)-1, length(xEst)];
            
        end;
        
    else
        %There was no observation available
       
    end;
            
    if(mod(k-2,40)==0)
        plot(xVehicleTrue(1),xVehicleTrue(2),'r*');
                
        %now draw all the estimated feature points
        DoMapGraphics(xEst,PEst,5);
        
        fprintf('k = %d\n',k);

        drawnow;                
    end;            
    
    
    %Storage:    
    for(i = 1:nFeatures)
        if(~isnan(MappedFeatures(i,1)))
            iL =MappedFeatures(i,1);
            PStore(k,i) = det(PEst(iL:iL+1,iL:iL+1));
            XErrStore(k,i) = norm(xEst(iL:iL+1)-Map(:,i));
        end;
    end;
    
    
  
end;


figure(2);
plot(PStore);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z,iFeature] = GetObservation(k)
global Map;global xVehicleTrue;global RTrue;global nSteps;

%choose a random feature to see from True Map
iFeature = ceil(size(Map,2)*rand(1));
z = DoObservationModel(xVehicleTrue,Map(:,iFeature))+sqrt(RTrue)*randn(2,1);
z(2) = AngleWrap(z(2));

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
function u = GetRobotControl(k)
global nSteps;
%u = [0; 0.25 ; 0.3*pi/180*sin(3*pi*k/nSteps)];
u = [0; 0.15 ; 0.3*pi/180];
