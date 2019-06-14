function d=dist2lines(x,y,l)
%DIST2LINE Calculate distance from points to a line.
%
%d=dist2line(x,y,l)
%x,y - points.
%l   - line vectors.
%d   - distance table showing distance from point (x(i),y(i)) to line l(:,i).

% v1.0  2002-05-21. Niclas Borlin, niclas@cs.umu.se.

% This could probably be vectorized...
pt1=zeros(2,size(l,2));
for i=1:size(l,2)
	% Find point on line closest to the origin.
	pt1(:,i)=[l(1:2,i)'\-l(3,i)];
end
% Find direction vector.
t=[l(2,:);-l(1,:)];

% Calculate closest point on line to each point.
p=[x,y]';
pp=p-pt1;
% This could probably also be vectorized...
alpha=zeros(1,size(l,2));
for i=1:size(l,2)
	alpha(i)=t(:,i)\pp(:,i);
end
q=pt1+alpha(ones(2,1),:).*t;
d=sqrt(sum((p-q).^2))';
