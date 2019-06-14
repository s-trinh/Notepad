function X=homonorm(X)
%HOMONORM Normalize homogenous points.
%
%X=homonorm(X);

% v1.0  2002-03-19. Niclas Borlin, niclas@cs.umu.se.

[m,n]=size(X);

X=X./X(end*ones(1,m),:);
