function DoMapGraphics(xMap,PMap,nSigma)
persistent k;

if(isempty(k))
    k = 0;
end;
k = k+1;

colors = 'kkkk';
for(i = 1:length(xMap)/2)
    iL = 2*i-1; iH = 2*i;
    x = xMap(iL:iH);
    P = PMap(iL:iH,iL:iH);    
    h = PlotEllipse(x,P,nSigma,k);  
    c = colors(mod(i,4)+1);
    set(h,'color',char(c));
   % plot3(x(1),x(2),k,'r+');
end;

%-------- Drawing Covariance -----%
function eH = PlotEllipse(x,P,nSigma,k)
eH = [];
P = P(1:2,1:2); % only plot x-y part
x = x(1:2);
if(~any(diag(P)==0))
    [V,D] = eig(P);
    y = nSigma*[cos(0:0.1:2*pi);sin(0:0.1:2*pi)];
    el = V*sqrtm(D)*y;
    el = [el el(:,1)]+repmat(x,1,size(el,2)+1);
    eH = line(el(1,:),el(2,:),k*ones(length(el(1,:)),1 ) );
end;

