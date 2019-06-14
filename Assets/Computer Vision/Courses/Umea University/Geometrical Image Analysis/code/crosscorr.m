function [r,s1,s2,m1,m2]=crosscorr(im1,im2,sz,i1,j1,i2,j2)
%CROSSCORR Calculate cross-image correlation used by the Foerster operator.
%
%[r,s1,s2,m1,m2]=crosscorr(im1,im2,sz,i1,j1,i2,j2)
%or
%[r,s1,s2]=crosscorr(m1,m2)
%
%im1,im2 - input images.
%sz      - correlation window size.
%i1,j1   - window center coordinates in image 1.
%i2,j2   - window center coordinates in image 2.
%m1,m2   - stacked windows.
%r       - correlation matrix.
%s1,s2   - vectors with window standard deviations.

% v1.0  2003-05-05. Niclas Borlin, niclas@cs.umu.se.

if (nargin>2)
	m1=[];
	m2=[];

	n1=length(i1);
	n2=length(i2);

	dx=-floor((sz(2)-1)/2):floor(sz(2)/2);
	dy=-floor((sz(1)-1)/2):floor(sz(1)/2);

	if (nargout>3)
		% Extract window stacks.
		m1=repmat(im1(i1(1)+dy,j1(1)+dx),[1,1,1,n1]);
		for i=1:n1
			m1(:,:,1,i)=im1(i1(i)+dy,j1(i)+dx);
		end

		m2=repmat(im2(i2(1)+dy,j2(1)+dx),[1,1,1,n2]);
		for i=1:n2
			m2(:,:,1,i)=im2(i2(i)+dy,j2(i)+dx);
		end
	end
else
	% m1, m2 are already stacked windows.
	m1=im1;
	m2=im2;
	sz1=size(m1);
	sz2=size(m2);
	if (any(sz1(1:2)~=sz2(1:2)))
		error('Sizes of stacked windows don''t match');
	end
	sz=sz1(1:2);
	n1=sz1(4);
	n2=sz2(4);
end

r=zeros(n1,n2);
s1=zeros(n1,1);
s2=zeros(n2,1);

if (isempty(m1))
	% Low memory version: don't use any window stack.
	for i=1:n1
		v1=im1(i1(i)+dy,j1(i)+dx);
		s1(i)=std(v1(:));
		for j=1:n2
			v2=im2(i2(j)+dy,j2(j)+dx);
			if (i==1)
				s2(j)=std(v2(:));
			end
			rr=corrcoef(v1(:),v2(:));
			r(i,j)=rr(1,2);
		end
	end
else
	s1=std(reshape(double(m1),prod(sz),n1));
	s2=std(reshape(double(m2),prod(sz),n2));
	for i=1:n1
		v1=double(m1(:,:,1,i));
		for j=1:n2
			v2=double(m2(:,:,1,j));
			rr=corrcoef(v1(:),v2(:));
			r(i,j)=rr(1,2);
		end
	end
end
