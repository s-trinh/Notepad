function c=calcfund_c(u,d)
%CALCFUND_C Constraint function for the fundamental matrix calculation.
%
%c=calcfund_c(u,d)
%u=[f1,..,f9,x1hx,x1hy,..,xmhx,xmhy,x1hpx,x1hpy,..,xmhpx,xmhpy]' parameters.
%d=[x1x,x1y,..xmx,xmy,x1px,x1py,..,xmpx,xmpy]' measured points.

% v1.0  2003-05-15. Niclas Borlin, niclas@cs.umu.se.

% Number of points.
n=length(d)/4;

% Unpack.
f=u(1:9);
xh=u(9+[1:n*2]);
xhp=u(9+2*n+[1:2*n]);

% Pack F
F=reshape(f,3,3)';

% Pack xhat as homogenous.
xhh=[reshape(xh,2,n);ones(1,n)];
xhph=[reshape(xhp,2,n);ones(1,n)];

c1=sum(xhph.*(F*xhh))';
c2=sum(F(:).^2)-1;
c3=det(F)*1e10;

c=[c1;c2;c3];
