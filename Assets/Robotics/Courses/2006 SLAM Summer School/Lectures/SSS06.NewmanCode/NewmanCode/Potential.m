function PotentialPath
clear all;
close all;
nFeatures = 1000;
MapSize = 100;
Map = MapSize*rand(2,nFeatures);


nMaxSteps = 300;
%Map = [10;9.9];

global xGoal;
xGoal = [MapSize;MapSize];
xStart = [0;0];
xVehicle = xStart;
RadiusOfInfluence = 60;

KGoal= 1;
KObj = 1;

GoalError =  xGoal - xVehicle;


figure(1);clf;hold on;set(gcf,'doublebuffer','on');
set(gcf,'Pointer','crosshair','doublebuffer','on');
set(gcf,'windowbuttondownfcn',@OnMouse);


plot(Map(1,:),Map(2,:),'rs');
plot(xGoal(1),xGoal(2),'gp');
Hr = DrawRobot([xVehicle;0],'r',[]);

k = 0;
while(norm(GoalError)>1 & k<nMaxSteps)
              
    
    %find distance to all entities
    Dp = Map-repmat(xVehicle,1,nFeatures);
    Distance = sqrt(sum(Dp.^2));
    iInfluencial = find(Distance<RadiusOfInfluence);
    
    if(~isempty(iInfluencial))
        %vector sum of repulsions:
        rho = repmat(Distance(iInfluencial),2,1);
        V = Dp(:,iInfluencial);
        DrhoDx = -V./rho;
        F = (1./rho-1./RadiusOfInfluence)*1./(rho.^2).*DrhoDx;
        FObjects = KObj*sum(F,2);    
    else
        %nothing close
        FObjects = [0;0];
    end;

    
    FGoal = KGoal*(GoalError)/norm(GoalError);
        
    FTotal = FGoal+FObjects;

    Magnitude = min(1,norm(FTotal));
    
    FTotal = FTotal/norm(FTotal)*Magnitude;
    
    xVehicle = xVehicle+FTotal;
    
    k = k+1;
         
    Theta = atan2(FTotal(2),FTotal(1));
    DrawRobot([xVehicle;Theta],'k',Hr);
    pause(0.1);
    drawnow;
    
    GoalError =  xGoal - xVehicle;
    
end;

function OnMouse(s,e)
global xGoal;
p = get(gca,'CurrentPoint');
xGoal = p(1,1:2)';


%-------- Drawing Vehicle -----%
function H = DrawRobot(Xr,col,H);

p=0.02; % percentage of axes size 
a=axis;
l1=(a(2)-a(1))*p;
l2=(a(4)-a(3))*p;
P=[-1 1 0 -1; -1 -1 3 -1];%basic triangle
theta = Xr(3)-pi/2;%rotate to point along x axis (theta = 0)
c=cos(theta);
s=sin(theta);
P=[c -s; s c]*P; %rotate by theta
P(1,:)=P(1,:)*l1+Xr(1); %scale and shift to x
P(2,:)=P(2,:)*l2+Xr(2);
if(isempty(H))
    H = plot(P(1,:),P(2,:),col,'LineWidth',0.1);% draw
else
    set(H,'XData',P(1,:));
    set(H,'YData',P(2,:));    
    set(H,'color',[0 1 0]);
end;


