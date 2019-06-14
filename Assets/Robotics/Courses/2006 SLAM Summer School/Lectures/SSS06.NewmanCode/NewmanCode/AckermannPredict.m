function AckermannPredict
clear all;
close all;

dT = 0.1;%time steps size
nSteps = 600;%length of run
L = 2;%length of vehicle
SigmaV = 0.1; %3cm/s std on speed
SigmaPhi = 4*pi/180; % steer inaccuracy

%initial knowledge pdf (prior @ k = 0)
P = diag([0.2,0.2,0]);x = [0;0;0];xtrue = x;

Q = diag([SigmaV^2 SigmaPhi^2]);

%-------- Set up graphics -----------%
figure(1);hold on;axis equal;grid on;axis([-20 20 -5 25])

xlabel('x');ylabel('y');
title('uncertainty bounds for Ackermann model');

%-------- Main loop -----------%
for(k = 1:nSteps)
    %control is a wiggle at constant velocity
    u = [1;pi/5*sin(4*pi*k/nSteps)];
    
    %calculate jacobians
    JacFx = [1 0 -dT*u(1)*sin(x(3)); 0 1 dT*u(1)*cos(x(3)); 0 0  1];     
    JacFu = [dT*cos(x(3)) 0; dT*sin(x(3)) 0; dT* tan(u(2))/L dT *u(1)*sec(u(2))^2];

    %prediction steps
    P = JacFx * P *JacFx' + JacFu*Q*JacFu';
    xtrue = AckermannModel(xtrue,u+[SigmaV ;SigmaPhi].*randn(2,1),dT,L);    
    x = AckermannModel(x,u,dT,L);    
    
    
    %draw occasionally
    if(mod(k-1,30)==0)
        PlotEllipse(x,P,0.5); DrawRobot(x,'r');plot(xtrue(1),xtrue(2),'ko');
    end;    
end;

print -deps 'AckermannPredict.eps'%save the picture

%------------ MODEL --------------%
function y = AckermannModel(x,u,dT,L)
y(1,1) = x(1) + dT*u(1)*cos(x(3));
y(2,1) = x(2) + dT*u(1)*sin(x(3));
y(3,1) = x(3) + dT*u(1)/L*tan(u(2));

%-------- Drawing Covariance -----%
function eH = PlotEllipse(x,P,nSigma)
P = P(1:2,1:2); % only plot x-y part
x = x(1:2);
if(~any(diag(P)==0))
    [V,D] = eig(P);
    y = nSigma*[cos(0:0.1:2*pi);sin(0:0.1:2*pi)];
    el = V*sqrtm(D)*y;
    el = [el el(:,1)]+repmat(x,1,size(el,2)+1);
    eH = line(el(1,:),el(2,:));
end;

%-------- Drawing Vehicle -----%
function DrawRobot(Xr,col);

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
H = plot(P(1,:),P(2,:),col,'LineWidth',0.1);% draw
plot(Xr(1),Xr(2),sprintf('%s+',col));