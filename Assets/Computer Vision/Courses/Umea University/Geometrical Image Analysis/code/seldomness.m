function [s,r,m]=seldomness(im,sz,i,j)
%SELDOMNESS Calculate region seldomness for Foerstner operator.
%
%[s,r,m]=seldomness(im,sz,i,j)
%im  - input image.
%sz  - window size to calculate correlation coefficient from.
%i,j - vectors with centers of windows.
%s   - vector of seldomness value.
%r   - correlation coefficient matrix.
%m   - image region stack.

% v1.0  2003-05-04. Niclas Borlin, niclas@cs.umu.se.

n=length(i);
r=zeros(n);
dx=-floor((sz(2)-1)/2):floor(sz(2)/2);
dy=-floor((sz(1)-1)/2):floor(sz(1)/2);

if (nargout<3)
	% Low memory version.
	
	% Calculate correlation coefficient between all windows.
	for ii=1:n-1
		vi=im(i(ii)+dy,j(ii)+dx);
		for jj=ii+1:n
			vj=im(i(jj)+dy,j(jj)+dx);
			c=corrcoef(vi(:),vj(:));
			r(ii,jj)=c(1,2);
			r(jj,ii)=c(1,2);
		end
	end
else
	% Stack all windows.
	m=repmat(im(i(1)+dy,j(1)+dx),[1,1,1,n]);
	for ii=1:n
		m(:,:,1,ii)=im(i(ii)+dy,j(ii)+dx);
	end
	r=corrcoef(reshape(double(m),[prod(sz),n]));
	r=r-eye(n);
end

% Find maximum corrcoef for each window.
ri=max(r)';
s=(1-ri)./ri;
s(ri<=0)=inf;
