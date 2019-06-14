function f=calcfund_f(u,d)
%CALCFUND_F Residual function for the fundamental matrix calculation.
%
%f=calcfund_f(u,d)
%u=[f1,..,f9,x1hx,x1hy,..,xmhx,xmhy,x1hpx,x1hpy,..,xmhpx,xmhpy]' parameters.
%d=[x1x,x1y,..xmx,xmy,x1px,x1py,..,xmpx,xmpy]' measured points.

% v1.0  2003-05-15. Niclas Borlin, niclas@cs.umu.se.

% Number of points.
n=length(d)/4;

f=u(1:9);
xh=u(9+[1:n*2]);
xhp=u(9+2*n+[1:2*n]);

x=d(1:2*n);
xp=d(2*n+[1:2*n]);

f=[xh-x;xhp-xp];
