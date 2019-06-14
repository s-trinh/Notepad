function [w,q,trM,detM,dx,dy,A,B,C]=corners(im,type,qMin,s,hx,hy)
%CORNERS Find Harris or Foerstner corners.
%
%R=corners(im,'harris',k[,s,hx,hy])
%or
%[w,q]=corners(im,'foerstner',qMin[,s,hx,hy])
%
%im   - input image.
%k    - Harris's constant, R=det-kTr^2
%qMin - Foerstner isotropy limit.
%s    - smoothing kernel. Defaults to no smoothing.
%hx   - x derivative kernel. Defaults to [-1,0,1].
%hy   - y derivative kernel. Defaults to [-1,0,1]'.
%R    - Harris's response function.
%w    - Foerstner interest value.
%q    - Foerstner isotropy value.

% v1.0  2003-05-02. Niclas Borlin, niclas@cs.umu.se.

if (nargin<3)
	error('Too few arguments');
end

isFoerstner=nan;

if (ischar(type) & ~isempty(type))
	switch (lower(type(1)))
	case 'h'
		isFoerstner=0;
	case 'f'
		isFoerstner=1;
	end
end

if (isnan(isFoerstner))
	error('Illegal corner type selector');
end


if (nargin<4 | isempty(s))
	s=1;
end

if (nargin<5 | isempty(hx))
	hx=[-1,0,1];
end

if (nargin<6 | isempty(hy))
	hy=[-1,0,1]';
end

% All kernels should be odd-sized.
if (any(rem(size(s),2)~=1))
	error('Smoothing kernel must be odd-sized')
end

if (any(rem(size(hx),2)~=1))
	error('X derivative kernel must be odd-sized')
end

if (any(rem(size(hy),2)~=1))
	error('Y derivative kernel must be odd-sized')
end

% Calculate how much must be trimmed after filtering.
tx=floor(max(size(hx,2),size(hy,2))/2)+floor(size(s,2)/2);
ty=floor(max(size(hx,1),size(hy,1))/2)+floor(size(s,1)/2);

% Approximate derivatives.
dx=conv2(double(im),hx,'same');
dy=conv2(double(im),hy,'same');

% Calculate covariance factors.
A=dx.^2;
B=dy.^2;
C=dx.*dy;

if (any(size(s)>1))
	% Smooth.
	A=conv2(A,s,'same');
	B=conv2(B,s,'same');
	C=conv2(C,s,'same');
end

% Calculate trace and determinant of covariance matrix.
trM=A+B;
detM=A.*B-C.^2;

if (~isFoerstner)
	% Harris corner detector.

	k=qMin;
	
	R=detM-k*trM.^2;
	% Trim edges.
	R([1:ty,end-ty+1:end],:)=0;
	R(:,[1:tx,end-tx+1:end])=0;
	w=R;
else
	% Foerstner interest operator.
	
	% Isotropy
	q=4*detM./(trM.^2+eps);
	q(detM==0 & trM==0)=0;
	
	% Interest value.
	w=detM./(trM+eps);
	w(detM==0 & trM==0)=0;
	
	% Remove all too non-circular points.
	w(q<=qMin)=0;

	% Trim edges.
	w([1:ty,end-ty+1:end],:)=0;
	w(:,[1:tx,end-tx+1:end])=0;

	q([1:ty,end-ty+1:end],:)=0;
	q(:,[1:tx,end-tx+1:end])=0;
end
