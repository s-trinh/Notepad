function i=localmax(im,sz)
%LOCALMAX Locate local maxima in image.
%
%i=localmax(im[,sz])
%im - input image.
%sz - size of local neighbourhood. Defaults to [3,3].
%i  - matrix with 1's for local maxima in im, otherwise 0's.

% v1.0  2003-05-02. Niclas Borlin, niclas@cs.umu.se.

if (nargin<2)
	sz=[3,3];
end

i=colfilt(im,sz,'sliding','islocalmax');
