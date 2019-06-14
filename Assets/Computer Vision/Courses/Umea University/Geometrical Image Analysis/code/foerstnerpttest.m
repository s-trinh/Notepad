% images from the Förstner papers
ims={[1,1,1,1,1
	  1,0,1,1,1
	  0,0,0,1,1
	  0,0,0,0,1
	  0,0,0,0,0],
	 [1,1,1,1,1
	  0,0,1,1,1
	  0,0,0,1,1
	  0,0,0,0,1
	  0,0,0,0,0],
	 [1,1,1,1,1
	  0,0,0,0,1
	  0,0,0,1,1
	  0,0,1,1,1
	  0,1,1,1,1],
	 [2,1,1,1,1
	  2,1,1,1,1
	  2,0,0,0,0
	  2,0,0,0,0
	  2,0,0,0,0],
	 [2,2,2,2,2
	  1,2,2,2,2
	  1,1,2,2,2
	  1,0,0,2,2
	  0,0,0,0,2],
	 [2,2,2,2,2,2,2
	  2,2,2,2,2,2,1
	  2,2,2,1,1,1,1
	  2,0,1,1,1,1,1
	  2,0,0,0,1,1,1
	  2,0,0,0,0,0,1
	  2,0,0,0,0,0,0],
	 [2,1,1,1,1,1,1
	  2,2,1,1,1,1,2
	  2,2,2,1,1,2,2
	  2,2,2,0,2,2,2
	  2,2,2,0,2,2,2
	  2,2,1,1,2,2,2
	  2,2,0,2,2,2,2],
	 [1,2,2,2,2,2,1
	  2,1,2,2,2,1,2
	  2,2,1,2,2,2,2
	  2,2,2,2,2,2,2
	  2,2,2,2,1,2,2
	  2,2,2,2,1,1,2
	  2,2,2,2,2,0,2],
	 [2,2,1,2,2,2,2
	  2,2,1,2,2,2,2
	  2,2,1,2,2,2,2
	  2,2,0,0,0,0,0
	  2,2,1,2,2,2,2
	  2,2,1,2,2,2,2
	  2,2,1,2,2,2,2],
	 [1,1,1,1,1,1,1,1,1
	  1,1,1,0,0,0,0,1,1
	  1,1,0,1,1,1,1,0,0
	  1,0,1,1,1,1,1,1,0
	  1,0,1,1,1,1,1,1,1
	  1,0,1,1,1,1,1,1,1
	  1,0,1,1,1,1,1,1,1
	  1,1,0,1,1,1,1,1,1
	  1,1,1,0,1,1,1,1,1],
	 [3,3,3,3,2,0,0,0,0
	  3,3,3,2,0,0,0,0,0
	  3,3,3,1,0,0,0,0,0
	  3,3,2,0,0,0,0,0,0
	  3,3,1,0,0,0,0,0,0
	  3,3,0,0,0,0,0,0,0
	  3,3,0,0,0,0,0,0,0
	  3,3,0,0,0,0,0,0,0
	  3,3,0,0,0,0,0,0,0],
	 [3,3,3,3,3,3
	  3,3,2,3,3,3
	  3,1,0,0,3,3
	  3,0,0,0,3,3
	  3,2,1,2,3,3
	  3,3,3,3,3,3],
	 [2,2,2,2,2
	  1,2,2,2,3
	  1,1,2,3,3
	  1,1,0,3,3
	  1,0,0,0,3],
	 [3,3,2,2,2
	  3,3,2,2,2
	  3,3,2,2,2
	  0,0,1,1,1
	  0,0,1,1,1],
	 [0,0,0,0,0,0,1
	  0,0,0,0,1,2,3
	  0,0,1,2,3,3,3
	  2,2,1,2,2,2,2
	  2,1,1,2,2,2,2
	  1,1,1,1,2,2,2
	  1,1,1,1,2,2,2],
	 [0,1,1,1,1
	  0,0,1,1,1
	  1,0,0,1,1
	  1,1,0,1,1
	  1,1,1,1,1],
	 [1,1,1,1,1
	  1,1,1,1,1
	  1,1,1,1,1
	  0,0,0,0,0
	  1,1,1,1,1],
	 [1,0,1,1,1
	  1,0,1,1,1
	  1,0,1,1,1
	  1,1,1,1,1
	  1,1,1,1,1],
	 [1,1,0,1,1,1,1
	  1,1,0,1,1,1,1
	  1,1,0,1,1,1,1
	  1,1,0,1,1,1,1
	  1,1,1,1,1,1,1
	  1,1,1,1,1,1,1
	  1,1,1,1,1,1,1],
	 [0,0,0,0
	  0,1,1,0
	  0,1,1,0
	  0,0,0,0]};
%sel=1;
i=ims{sel};

grad='roberts';
switch (grad)
case 'roberts'
	% gradients along diagonals.
	hy=[-1,-1;1,1];
	hx=hy';
case 'sobel'
	% sobel gradients
	hy=[1,2,1;0,0,0;-1,-2,-1];
	hx=hy';
case 'thin'
	hy=[0,1,0;0,0,0;0,-1,0];
	hx=hy';
end
gy=conv2(i,hy,'valid');
gx=conv2(i,hx,'valid');

% Elements of the normal equation matrices.
n11=sum(gy(:).^2);
n12=sum(gy(:).*gx(:));
n22=sum(gx(:).^2);

% Coordinates for filter centers.
[y,x]=indices(size(gy));
y=y+(size(hy,1)-1)/2;
x=x+(size(hx,2)-1)/2;

% Precalculate gradient norm, norm^2 and direction.
g2=gx.^2+gy.^2;
g1=sqrt(g2);
g1nz=g1~=0;
cosa=zeros(size(gx));
sina=zeros(size(gx));
% To avoid division by zero.
cosa(g1nz)=gx(g1nz)./g1(g1nz);
sina(g1nz)=gy(g1nz)./g1(g1nz);

% Edge model.

% Equation 7c,8c in Förstner, Gulch (1987) paper, but with gy=gr, gx=gc.
h11=sum(gy(:).^2.*y(:))+sum(gy(:).*gx(:).*x(:));
h12=sum(gy(:).*gx(:).*y(:))+sum(gx(:).^2.*x(:));
N1=[n11,n12;n12,n22];
h1=[h11;h12];
y1=N1\h1;
if (0)
	% Comparison with weighted intersection of edges interpretation.
	A1=[sina(:),cosa(:)];
	W1=diag(g2(:));
	b1=[x(:).*cosa(:)+y(:).*sina(:)];
	yy1=(A1'*W1*A1)\(A1'*W1*b1);
	disp([norm(A1'*W1*A1-N1),norm(A1'*W1*b1-h1),norm(yy1-y1)])
	r1=A1*y1-b1;
	nr1=r1'*W1*r1;
else
	% Comparison with weighted center of gravity interpretation, eq. 4-5
    % in Förster (1986) paper.
	A1=[gy(:),gx(:)];
	b1=[x(:).*gx(:)+y(:).*gy(:)];
	yy1=A1\b1;
	%disp([norm(A1'*A1-N1),norm(A1'*b1-h1),norm(yy1-y1)])
	r1=A1*y1-b1;
	% Residual norm for edge model.
	nr1=r1'*r1;
	
	C1=inv(A1'*A1);
	sigma01=sqrt(r1'*r1/(length(r1)-2));
	[V1,D1]=eig(C1);
end

% Circle model

% Equation 9c in Förstner, Gulch (1987) paper, but with gy=gr, gx=gc.
h21=sum(gx(:).^2.*y(:))-sum(gy(:).*gx(:).*x(:));
h22=-sum(gy(:).*gx(:).*y(:))+sum(gy(:).^2.*x(:));
N2=[n22,-n12;-n12,n11];
h2=[h21;h22];
y2=N2\h2;
if (0)
	% Comparison with weighted intersection of slopes interpretation.
	A2=[cosa(:),-sina(:)];
	W2=diag(g2(:));
	b2=[x(:).*(-sina(:))+y(:).*cosa(:)];
	yy2=(A2'*W2*A2)\(A2'*W2*b2);
	disp([norm(A2'*W2*A2-N2),norm(A2'*W2*b2-h2),norm(yy2-y2)])
	r2=A2*y2-b2;
	nr2=r2'*W2*r2;
else
	% Comparison with weighted center of gravity interpretation, eq. 4-6
    % in Förster (1986) paper.
	% Note: Equation 4-6 should probably be intrepreted as
	% di=xi*(-sin(alphai))+yi*cos(alphai)
	A2=[gx(:),-gy(:)];
	b2=[-x(:).*gy(:)+y(:).*gx(:)];
	yy2=A2\b2;
	%disp([norm(A2'*A2-N2),norm(A2'*b2-h2),norm(yy2-y2)])
	r2=A2*y2-b2;
	% Residual norm for circle model.
	nr2=r2'*r2;

	C2=inv(A2'*A2);
	sigma02=sqrt(r2'*r2/(length(r2)-2));
	[V2,D2]=eig(C2);
end

t=linspace(0,2*pi);

set(figure(1),'name','Edge model');
imshow(rescale(i,0.4,0.6),128);
line(y1(2),y1(1),'marker','x','color','w')
xy1=repmat(y1,1,length(t))+3*sigma01*V1*sqrt(D1)*[cos(t);sin(t)];
line(xy1(2,:),xy1(1,:),'color','w')
hold on
quiver(x,y,gy,-gx,0.5,'wx')
quiver(x,y,-gy,gx,0.5,'wx')
hold off

set(figure(2),'name','Circle model');
imshow(rescale(i,0.4,0.6),128);
line(y2(2),y2(1),'marker','o','color','w')
xy2=repmat(y2,1,length(t))+3*sigma02*V2*sqrt(D2)*[cos(t);sin(t)];
line(xy2(2,:),xy2(1,:),'color','w')
hold on
quiver(x,y,gx,gy,0.5,'wx');
hold off

set(figure(3),'name','Gradient images')
imshow(srescale([gx,gy]),128)

disp('Edge model residual')
disp(nr1)
disp('Circle model residual')
disp(nr2)
if (nr1<nr2)
	disp('Region is probably an edge')
else
	disp('Region is probably a circle');
end

	