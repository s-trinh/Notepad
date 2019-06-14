function A=calcfund_a(u,d)
%CALCFUND_A Constraint jacobian for the fundamental matrix calculation.
%
%A=calcfund_A(u,d)
%u=[f1,..,f9,x1hx,x1hy,..,xmhx,xmhy,x1hpx,x1hpy,..,xmhpx,xmhpy]' parameters.
%d=[x1x,x1y,..xmx,xmy,x1px,x1py,..,xmpx,xmpy]' measured points.

% v1.0  2003-05-15. Niclas Borlin, niclas@cs.umu.se.

% Number of points.
n=length(d)/4;

% Unpack.
f=u(1:9);
xh=u(9+[1:n*2]);
xhp=u(9+2*n+[1:2*n]);

xhpx=xhp(1:2:end);
xhpy=xhp(2:2:end);

xhx=xh(1:2:end);
xhy=xh(2:2:end);

% dc/dfi
Af=[xhpx.*xhx,xhpx.*xhy,xhpx,xhpy.*xhx,xhpy.*xhy,xhpy,xhx,xhy,ones(n,1)];

% dc/dxh
Axhx=sparse(1:n,2*(0:n-1)+1,xhpx*f(1)+xhpy*f(4)+f(7),n,2*n);
Axhy=sparse(1:n,2*(0:n-1)+2,xhpx*f(2)+xhpy*f(5)+f(8),n,2*n);
Axh=Axhx+Axhy;

% dc/dxhp
Axhpx=sparse(1:n,2*(0:n-1)+1,xhx*f(1)+xhy*f(2)+f(3),n,2*n);
Axhpy=sparse(1:n,2*(0:n-1)+2,xhx*f(4)+xhy*f(5)+f(6),n,2*n);
Axhp=Axhpx+Axhpy;

A1=[Af,Axh,Axhp];

% dcm+1
A2=[2*f',zeros(1,4*n)];

% dcm+2
p=[5,9,
   6,7,
   4,8,
   3,8,
   1,9,
   2,7,
   2,6,
   3,4,
   1,5];
m=[6,8,
   4,9,
   5,7,
   2,9,
   3,7,
   1,8,
   3,5,
   1,6,
   2,4];
A3=[[prod(f(p),2)-prod(f(m),2)]',zeros(1,4*n)]*1e10;

A=[A1;A2;A3];
