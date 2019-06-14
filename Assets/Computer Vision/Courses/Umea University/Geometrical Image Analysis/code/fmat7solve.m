function [F1,F2,F3]=fmat7solve(f1,f2)
%FMAT7SOLVE Solve for rank-2 fundamental matrix from 7 point correspondence.
%
%Solves the problem
%
%             f=alpha*f1+(1-alpha)*f2,
%      s.t. det(F)==0 and F=reshape(f,3,3)
%          
%[F1,F2,F3]=fmat7solve(f1,f2)
%f1,f2 - null vectors of 7 point correspondence matrix.
%F1    - one real solution.
%F2,F3 - two more real solutions, or the empty matrix if no more real
%        solution exist.

% v1.0  2002-05-16. Niclas Borlin, niclas@cs.umu.se.

% Create polynomial vectors for m=alpha f1+(1-alpha) f2.
m=[f1,zeros(size(f1))]+[-f2,f2];

% Create the cubic terms of the determinant
% det(M)=prod(m([1,5,9]))+prod(m([2,6,7]))+prod(m([3,4,8]))...
%        -prod(m([1,6,8]))-prod(m([2,4,9]))-prod(m([3,5,7]))
t159=conv(m(1,:),conv(m(5,:),m(9,:)));
t267=conv(m(2,:),conv(m(6,:),m(7,:)));
t348=conv(m(3,:),conv(m(4,:),m(8,:)));
t168=conv(m(1,:),conv(m(6,:),m(8,:)));
t249=conv(m(2,:),conv(m(4,:),m(9,:)));
t357=conv(m(3,:),conv(m(5,:),m(7,:)));

% Construct determinant polynomial in alpha.
dt=t159+t267+t348-t168-t249-t357;

% Solve for alpha.
alpha=roots(dt);

% Sort real solutions first.
[dummy,i]=sort(abs(imag(alpha)));

% Create first solution (always real).
F1=reshape(alpha(i(1))*f1+(1-alpha(i(1)))*f2,3,3)';

if (isreal(alpha(i(2))))
	% We have two more real solutions.
	F2=reshape(alpha(i(2))*f1+(1-alpha(i(2)))*f2,3,3)';
	F3=reshape(alpha(i(3))*f1+(1-alpha(i(3)))*f2,3,3)';
else
	% Only one real solution.
	F2=[];
	F3=[];
end


