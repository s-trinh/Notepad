function [F,xh,xhp,xx,cc,rr]=calcfundgeom(x,xp,normalize,constrain)
%CALCFUNDGEOM Calculate fundamental matrix by minimizing geometric error.
%
%[F,xh,xhp]=calcfundgeom(x,xp)
%x   - points in image 1.
%xp  - points in image 2.
%F   - optimal fundamental matrix with frobenius norm=1.
%xh  - estimated points on epipolar line in image 1.
%xhp - estimated points on epipolar line in image 2.

% v1.0  2003-05-15. Niclas Borlin, niclas@cs.umu.se.

if (size(x,1)>2)
    x=x(1:2,:)./x([3,3],:);
end

if (size(xp,1)>2)
    xp=xp(1:2,:)./xp([3,3],:);
end

% Starting approximation.
F0=fundmat8([x;ones(1,size(x,2))],[xp;ones(1,size(xp,2))],normalize,constrain);
% Normalize.
F0=F0/norm(F0,'fro');

F0=F0';
u0=[F0(:);x(:);xp(:)];

% Data.
d=[x(:);xp(:)];
params={d};

maxIter=20;
epsf=1e-4;
epsg=1e-8;

[u,n,code,lambda,res,xx,cc,ll]=sqpw('calcfund','calcfund',u0,maxIter, ...
                                    epsf,epsg,speye(length(d)),params);

F=reshape(u(1:9),3,3)';
xh=reshape(u(9+[1:2*size(x,2)]),2,size(x,2));
xhp=reshape(u(9+2*size(x,2)+[1:2*size(xp,2)]),2,size(xp,2));

if (nargout>5)
    rr=zeros(length(res),size(xx,2));
    for i=1:size(xx,2)
        rr(:,i)=calcfund_f(xx(:,i),params{:});
    end
end

