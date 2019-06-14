% Transformation.
H=[1.434,-0.264,2.248;0.241,0.899,2.481;0.143,-0.026,1];
% Point grid.
[x,y]=meshgrid(-5:5,-5:5);
X=[x(:)';y(:)';ones(1,prod(size(x)))];
% Lines.
l=[1,0,-1.3]';
m=[0,1,-4.3]';
% Conic (unit circle).
C=diag([1,1,-1]);
% Tangential points on circle.
Cpts=[1,0,-1,0;
	  0,1,0,-1;
	  1,1,1,1];

figure(1)
plot(X(1,:),X(2,:),'b+');
drawhomoline([l,m]);
hold on
drawconic(C,Cpts);
hold off
axis tight

figure(2)
% Transform points, lines and conic.
XP=normhomo(H*X);
lp=H'\l; % inv(H')*l
mp=H'\m; % inv(H')*m
Cp=H'\C*inv(H); % inv(H')*C*inv(H)
plot(XP(1,:),XP(2,:),'b+')
drawhomoline([lp,mp]);
hold on
drawconic(Cp,H*Cpts)
hold off
axis([-15,8,-10,15])

