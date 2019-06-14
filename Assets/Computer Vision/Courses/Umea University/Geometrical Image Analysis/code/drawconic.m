function drawconic(C,X)
%DRAWCONIC Draw conic C.
%
%drawconic(C,X)
%C - 3x3 matrix describing the conic.
%X - homogenous points on the conic.

% v1.0  2002-03-19. Niclas Borlin, niclas@cs.umu.se.

if (nargin<2)
	% No points supplied. Find out which region we should analyze.
	switch (rank(C))
	case 3
		% Full rank.
		U=C(1:2,1:2);
		b=2*C(1:2,3);
		gamma=-C(3,3);
		[c,ax,delta,Q]=mat2geo(U,b,gamma);
		ax2=Q*diag(ax);
		X=[c(:,ones(1,4))+[ax2,-ax2];ones(1,4)];
		if (~isreal(X))
			warning('X is complex')
			X=real(X);
		end
	case 2
		% Two lines, intersection is in the null-space.
		x=null(C);
		if (abs(x(3))>eps*prod(size(C)))
			% Real point. Use as center.
			x=x/x(3);

			% Find direction of lines.
			C=C/C(3,3)*2;
			b=C(2,3)/2+sqrt(C(2,3)^2/4-C(2,2)/2);
			e=C(2,3)-b;
			a1=C(1,3)/2+sqrt(C(1,3)^2/4-C(1,1)/2);
			a2=C(1,3)/2-sqrt(C(1,3)^2/4-C(1,1)/2);
			x1=x+[-b;a1;0];
			x2=x+[-b;a2;0];
			if (abs(x1'*C*x1)<abs(x2'*C*x2))
				a=a1;
			else
				a=a2;
			end
			d=C(1,3)-a;
			v1=[-b;a;0];
			v2=[-e;d;0];
			X=[x,x+v1,x-v1,x+v2,x-v2];
		else
			% Parallel lines.
			C=C/C(3,3)*2;
			a1=C(1,3)/2+sqrt(C(1,3)^2/4-C(1,1)/2);
			a2=C(1,3)/2-sqrt(C(1,3)^2/4-C(1,1)/2);
			b1=C(2,3)/2+sqrt(C(2,3)^2/4-C(2,2)/2);
			b2=C(2,3)/2-sqrt(C(2,3)^2/4-C(2,2)/2);
			l1=[a1;b1;1];
			l2=[a2;b2;1];
			% Find points on lines closest to the origin.
			x1=[l1(1:2)'\-l1(3);1];
			x2=[l2(1:2)'\-l2(3);1];
			X=[x1,x2];
		end
	case 1
		% Single line.
		C=C/C(3,3);
		l=C(:,3);
		% Find point on line closest to the origin.
		x0=[l(1:2)'\-l(3);1];
		x1=x0+[null(l(1:2)');0];
		x2=x0-[null(l(1:2)');0];
		X=[x0,x1,x2];
	otherwise
		error('Illegal rank of conic');
	end
end

% Normalize the points.
X=normhomo(X);

x=X(1,:);
y=X(2,:);

plot(x,y,'r+');

% Find elongation in either direction.
rx=max(x)-min(x);
ry=max(y)-min(y);
r=max(rx,ry);

% and center.
cx=mean([max(x),min(x)]);
cy=mean([max(y),min(y)]);

[xx,yy]=meshgrid(linspace(cx-r,cx+r),linspace(cy-r,cy+r));
XX=[xx(:)';yy(:)';ones(1,prod(size(xx)))];

% Calculate x'Cx for all pts (xx,yy)
Z=sum(XX.*(C*XX));
Z=reshape(Z,size(xx));

% Draw contour line x'Cx=0 in blue.
hold on
[dummy,h]=contour(xx,yy,Z,[0 0]);
set(h,'edgecolor','b')
axis([cx-r,cx+r,cy-r,cy+r])
axis equal
hold off

if (rank(C)>1)
	% Calculate tangents.
	L=C*X;
	% Find degenerate tangents.
	degenerate=sqrt(sum(L.^2))<prod(size(L))*eps
	% Extract direction.
	l=L(1:2,:);
else
	% Line is 3rd column of C.
	C=C/C(3,3);
	l=C(1:2,3*ones(1,size(X,2)));
	degenerate=logical(zeros(1,size(X,2)));
end
	
% Normalize.
ln=sqrt(sum(l.^2));
ln(degenerate)=1;
l=l./ln(ones(2,1),:);
l(:,degenerate)=0;
l=[0,1;-1,0]*l;
xy=[x;y];
xy1=xy+l;
xy2=xy-l;
x=[xy1(1,:);xy2(1,:);nan*ones(1,size(xy1,2))];
y=[xy1(2,:);xy2(2,:);nan*ones(1,size(xy1,2))];
% Draw tangets in red.
line(x,y,'color','r');
