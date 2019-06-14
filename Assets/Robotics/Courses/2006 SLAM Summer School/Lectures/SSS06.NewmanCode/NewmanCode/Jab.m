function Jac=Jab(tab)

if size(tab,1) ~= 3,
   error('J tab is not a transformation!!!');
end;
s = sin(tab(3));
c = cos(tab(3));
Jac = [c -s  tab(2)
       s  c -tab(1)
       0  0  1];