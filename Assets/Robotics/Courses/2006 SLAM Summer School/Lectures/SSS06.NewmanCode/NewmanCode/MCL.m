%Monte-carlo based localisation
%note this is not coded efficiently but rather to make the ideas clear
%all loops should be vectorized but that gets a little matlab-speak intensive
%and may obliterate the elegance of a particle filter....

function MCL
close all; clear all;
global xTrue;global Map;global RTrue;global UTrue;global nSteps;


nSteps = 6000;

%change this to see how sensitive we are to the number of particle
%(hypotheses run) especially in relation to initial distribution!
nParticles = 400;

Map = 140*rand(2,30)-70;

UTrue = diag([0.01,0.01,1*pi/180]).^2;
RTrue = diag([2.0,3*pi/180]).^2;

UEst = 1.0*UTrue;
REst = 1.0*RTrue;

xTrue = [1;-40;-pi/2];
xOdomLast = GetOdometry(1);

%initial conditions: - a point cloud around truth
xP =repmat(xTrue,1,nParticles)+diag([15,15,0.4])*randn(3,nParticles);

%%%%%%%%%  storage  %%%%%%%%

%initial graphics
figure(1); hold on; grid off; axis equal;
plot(Map(1,:),Map(2,:),'g*');hold on;
set(gcf,'doublebuffer','on');
hObsLine = line([0,0],[0,0]);
set(hObsLine,'linestyle',':');
hPoints = plot(xP(1,:),xP(2,:),'.');

for k = 2:nSteps
    
    %do world iteration
    SimulateWorld(k);
    
    pause(0.4);
    
    %all particles are equally important
    L = ones(nParticles,1)/nParticles;
    
    
    %figure out control
    xOdomNow = GetOdometry(k);
    u = tcomp(tinv(xOdomLast),xOdomNow);
    xOdomLast = xOdomNow;
    
    %do prediction
    %for each particle we add in control vector AND noise
    %the control noise adds diversity within the generation
    for(p = 1:nParticles)
        xP(:,p) = tcomp(xP(:,p),u+sqrt(UEst)*randn(3,1));   
    end;
    
    xP(3,:) = AngleWrap(xP(3,:));

        
    %observe a randomn feature
    [z,iFeature] = GetObservation(k);
        
    if(~isempty(z))
        %predict observation
    
        for(p = 1:nParticles)
            %what do we expect observation to be for this particle?
            zPred = DoObservationModel(xP(:,p),iFeature,Map);
            
            %how different
            Innov = z-zPred;
            
            %get likelihood (new importance). Assume gaussian here but any pdf works!
            %if predicted obs is very different from actual obs this score will be low
            %->this particle is not very good at representing state. A lower score means
            %it is less likely to be selected for the next generation...
            L(p) = exp(-0.5*Innov'*inv(REst)*Innov)+0.001;
             
        end;     
    end;

    
    %reselect based on weights:
    %particles with big weights will occupy a greater percentage of the
    %y axis in a cummulative plot
    CDF = cumsum(L)/sum(L);
    %so randomly (uniform) choosing y values is more likely to correspond to
    %more likely (better) particles...
    iSelect  = rand(nParticles,1);
    %find the particle that corresponds to each y value (just a look up)
    iNextGeneration = interp1(CDF,1:nParticles,iSelect,'nearest','extrap');
    %copy selected particles for next generation..
    xP = xP(:,iNextGeneration);
    
    %our estimate is simply the mean of teh particles
    xEst = mean(xP,2);
      
    if(mod(k-2,10)==0)
           
        figure(1);
        set(hPoints,'XData',xP(1,:));
        set(hPoints,'YData',xP(2,:));
        if(~isempty(z))
            set(hObsLine,'XData',[xEst(1),Map(1,iFeature)]);
            set(hObsLine,'YData',[xEst(2),Map(2,iFeature)]);
        end;   
        figure(2);plot(xP(1,:),xP(2,:),'.');title('Particle Distribution');
        drawnow;        
    end;            
    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z,iFeature] = GetObservation(k)
global Map;global xTrue;global RTrue;global nSteps;

%fake sensor failure here
if(abs(k-nSteps/2)<0.1*nSteps)
    z = [];
    iFeature = -1;
else    
    iFeature = ceil(size(Map,2)*rand(1));
    z = DoObservationModel(xTrue, iFeature,Map)+sqrt(RTrue)*randn(2,1);
    z(2) = AngleWrap(z(2));
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z] = DoObservationModel(xVeh, iFeature,Map)
Delta = Map(1:2,iFeature)-xVeh(1:2);
z = [norm(Delta);
    atan2(Delta(2),Delta(1))-xVeh(3)];
z(2) = AngleWrap(z(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SimulateWorld(k)
global xTrue;
u = GetRobotControl(k);
xTrue = tcomp(xTrue,u);
xTrue(3) = AngleWrap(xTrue(3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xnow] = GetOdometry(k)
persistent LastOdom; %internal to robot low-level controller
global UTrue;
if(isempty(LastOdom))
    global xTrue;
    LastOdom = xTrue;
end;
u = GetRobotControl(k);
xnow =tcomp(LastOdom,u);
uNoise = sqrt(UTrue)*randn(3,1);
xnow = tcomp(xnow,uNoise);
LastOdom = xnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u = GetRobotControl(k)
global nSteps;
u = [0; 0.025 ; 0.1*pi/180*sin(3*pi*k/nSteps)];
