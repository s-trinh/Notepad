function i=islocalmax(im)
%ISLOCALMAX Local maximum filter.
%
%ISLOCALMAX is a function that when used as a column filter finds the
%positions of local maxima. E.g. after
%
%mx=colfilt(IM,[3,3],'sliding','islocalmax')
%
%the matrix mx will contain 1's where the pixels in IM are the largest in
%a 3x3 neighbourhood.
%
%i=islocalmax(im)
%im - columnconverted image. 
%i  - vector with 1's for local maxima, otherwise 0's.

% v1.0  2002-05-16. Niclas Borlin, niclas@cs.umu.se.
% v1.01 2003-05-02. Renamed to islocalmax.

[dummy,i]=max(im);

% Find position that should be maximum.
n2=floor(size(im,1)/2)+1;

% Only keep positions that have strict maximum at center position.
i=i==n2 & im(n2,:)>im(1,:);
