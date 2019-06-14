function [c,ax,delta,Q]=mat2geo(U,b,gamma)
%MAT2GEO Convert ellipse equation parameters from matrix to geometrical form.
%
%[c,ax,delta,Q]=mat2geo(U,b,gamma)
%
%Input form:
%
%x'*U*x + b'*x - gamma = 0
%
%Output form:
%            (x-c(1))^2   (y-c(2))^2
%            ---------- + ---------- - 1 = 0
%              ax(1)^2      ax(2)^2
%with rotation delta (not shown).

% v1.0  2000-05-13. Niclas Borlin, niclas@cs.umu.se.
% v1.1  2002-05-10. Changed to use atan2 to get angle.

c=-1/2*(U\b);
k=gamma+c'*U*c;
[Q,L]=eig(U);
L=L/k;
ax=1./sqrt(diag(L));
if (Q(1,1)==0)
	delta=pi/2;
else
	delta=atan(Q(2,1)/Q(1,1));
end
