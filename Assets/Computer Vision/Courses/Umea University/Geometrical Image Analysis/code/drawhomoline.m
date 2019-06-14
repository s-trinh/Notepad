function h=drawhomoline(L,varargin)
%DRAWHOMOLINE Draw homogenous line in current axis.
%
%h=drawhomoline(L[,line attributes])
%L - matrix with homogenous lines in each column.
%h - graphic handles.

% v1.0  2002-03-24. Niclas Borlin, niclas@cs.umu.se.

% Get axes scaling.
ax=axis;
xlim=ax(1:2);
ylim=ax(3:4);

% Construct lines for each side of the axis.
axL=[1,1,0,0;
     0,0,1,1;
     -xlim,-ylim];

h=zeros(size(L,2),1);
for i=1:size(L,2)
    l=L(:,i);
    % Determine if line is more vertical or horizontal.
    if (abs(l(1))<abs(l(2)))
        % More horizontal. Calculate intersection to left/right sides.
        x1=normhomo(lines2pt(l,axL(:,1)));
        x2=normhomo(lines2pt(l,axL(:,2)));
    else
        % More vertical. Calculate intersection to upper/lower sides.
        x1=normhomo(lines2pt(l,axL(:,3)));
        x2=normhomo(lines2pt(l,axL(:,4)));
    end
    h(i)=line([x1(1),x2(1)],[x1(2),x2(2)],varargin{:});
end
