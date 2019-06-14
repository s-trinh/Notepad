function DoVehicleGraphics(x,P,nSigma,Forwards)
ShiftTheta = atan2(Forwards(2),Forwards(1));
h = PlotEllipse(x,P,nSigma);
if(~isempty(h))
    set(h,'color','r');
end;
DrawRobot(x,'b',ShiftTheta);

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
    eH = line(el(1,:),el(2,:));
end;

%-------- Drawing Vehicle -----%
function DrawRobot(Xr,col,ShiftTheta);

p=0.02; % percentage of axes size 
a=axis;
l1=(a(2)-a(1))*p;
l2=(a(4)-a(3))*p;
P=[-1 1 0 -1; -1 -1 3 -1];%basic triangle
theta = Xr(3)-pi/2+ShiftTheta;%rotate to point along x axis (theta = 0)
c=cos(theta);
s=sin(theta);
P=[c -s; s c]*P; %rotate by theta
P(1,:)=P(1,:)*l1+Xr(1); %scale and shift to x
P(2,:)=P(2,:)*l2+Xr(2);
H = plot(P(1,:),P(2,:),col,'LineWidth',0.1);% draw
plot(Xr(1),Xr(2),sprintf('%s+',col));