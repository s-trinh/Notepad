function a = AngleWrap(a)

if(a>pi)
    a=a-2*pi;
elseif(a<-pi)
    a = a+2*pi;
end;
