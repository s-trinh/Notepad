function J=calcfund_j(u,d)
%CALCFUND_J Jacobian function for the fundamental matrix calculation.
%
%J=calcfund_j(u,d)
%u=[f1,..,f9,x1hx,x1hy,..,xmhx,xmhy,x1hpx,x1hpy,..,xmhpx,xmhpy]' parameters.
%d=[x1x,x1y,..xmx,xmy,x1px,x1py,..,xmpx,xmpy]' measured points.

% v1.0  2003-05-15. Niclas Borlin, niclas@cs.umu.se.

% Number of points.
n=length(d)/4;

J=sparse(1:4*n,9+[1:4*n],1);
