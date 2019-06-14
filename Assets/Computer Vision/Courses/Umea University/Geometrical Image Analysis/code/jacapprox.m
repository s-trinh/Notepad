function J=jacapprox(fun,x,h,params)
%JACAPPROX Numerical approximation of jacobian.
%
%J=jacapprox(fun,x,h,params)
%fun    - name of residual function.
%x      - point to evaluate in.
%h      - forward steplength(s). Defaults to 1e-6.
%params - optionally extra parameters to fun. Defaults to none.
%J      - numerically approximated jacobian.

% v1.0  2003-01-21. Niclas Borlin, niclas@cs.umu.se.
% v1.01 2003-01-22. Now uses central differences.

if (nargin<3 | isempty(h))
	h=1e-6;
end

if (nargin<4)
	params={};
end

n=length(x);
f0=feval(fun,x,params{:});
J=zeros(length(f0),n);
if (length(h)==1)
	h=ones(size(x))*h;
end
I=eye(n);

for i=1:n
	J(:,i)=(feval(fun,x+h(i)*I(:,i),params{:})-...
			feval(fun,x-h(i)*I(:,i),params{:}))/(2*h(i));
end
