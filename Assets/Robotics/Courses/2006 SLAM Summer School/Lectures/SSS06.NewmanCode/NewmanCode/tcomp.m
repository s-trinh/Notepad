 %-------------------------------------------------------
% composes two transformations
%
% Author:  Jose Neira
% Version: 1.0, 7-Dic-2000
%-------------------------------------------------------
% History:
%-------------------------------------------------------
function tac=tcomp(tab,tbc),

if size(tab,1) ~= 3,
   error('TCOMP: tab is not a transformation!!!');
end;

if size(tbc,1) ~= 3,
   error('TCOMP: tbc is not a transformation!!!');
end;

result = tab(3)+tbc(3);

if result > pi | result <= -pi
   result = AngleWrap(result) ;
end

s = sin(tab(3));
c = cos(tab(3));
tac = [tab(1:2)+ [c -s; s c]*tbc(1:2);
       result];