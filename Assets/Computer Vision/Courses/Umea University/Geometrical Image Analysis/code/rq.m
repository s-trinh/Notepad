function [R,Q]=rq(A)
%RQ Compute the RQ-factorization of A.
%
%Orthogonal-triangular decomposition [R,Q]=rq(A) such that R*Q=A.
%
%[R,Q]=rq(A)
%A - square matrix.
%R - right triangular matrix.
%Q - orthogonal matrix.
%
%See also QR.

% v1.0  1999-11-02. Niclas Borlin, niclas@cs.umu.se.

[m,n]=size(A);

if (m~=n)
	error('A must be square')
end

Q=eye(m);

for i=n:-1:1
	% Create a householder vector.
	u=house(A(i,1:i));
	if (0)
		% Matrix formulation.
		H=eye(length(u))-2*u'*u;
		A(1:i,1:i)=A(1:i,1:i)*H;
		Q(:,1:i)=Q(:,1:i)*H;
	else
		% Minimal flops.
		A(1:i,1:i)=housemul(u,A(1:i,1:i));
		A(i,1:i-1)=0;
		Q(:,1:i)=housemul(u,Q(:,1:i));
	end
end

Q=Q';
R=A;

function u=house(x)
% function u=house(x)
% returns the Householder vector such that all elements but the last in 
% (I-2*u*u')*x is zero.

n=norm(x);
u=x;
u(end)=u(end)+sign(u(end))*n;
u=u/norm(u);

function z=housemul(u,y)
% function z=housemul(u,y)
% Applies the Householder transformation (I-2*u*u') to y from the right
% without actually calculating (I-2*u*u')

z=y-2*(y*u')*u;

