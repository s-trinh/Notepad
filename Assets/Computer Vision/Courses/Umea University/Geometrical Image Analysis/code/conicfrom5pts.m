function C=conicfrom5pts(x,y)
%CONICFROM5PTS Calculate point conic from 5 points.
%
%C=conicfrom5pts(x,y)

% v1.0  2002-03-19. Niclas Borlin, niclas@cs.umu.se.

if (length(x)~=5 | length(y)~=5)
	error('Must be 5 pts')
end
x=x(:);
y=y(:);

M=[x.^2,x.*y,y.^2,x,y,ones(size(x))];
c=null(M);
c2=c.*[2,1,2,1,1,2]';
C=zeros(3);
C(:)=c2([1,2,4,2,3,5,4,5,6])/2;
