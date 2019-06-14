function [x,n,code,lambda,res,xx,cc,ll]=sqpw(prob,con,x0,maxIter,epsf,epsc,W,params)
%SQPW Sequential quadratic programming, undamped, weighted version.
%
%[x,n,code,lambda,res,xx,cc,ll]=sqpw(prob,con,x0,maxIter,epsf,epsc,W,params)
%prob    - stub name of problem. Will use prob appended by _f, _j
%          as residual and jacobian, respectively
%con     - stub name of constraints. Will use con appended by _c and _a
%          as constraint and constraint jacobian, respectively.
%x0      - starting approximation.
%maxIter - maximum # of iterations.
%epsf    - convergence tolerance for |Jp|/(1+|F|) (scalar).
%epsc    - convergence tolerance for |c| (scalar or vector).
%W       - weight matrix.
%params  - parameters to pass along to objective functions etc.
%x       - solution.
%n       - number of iterations.
%code    - error code: 0 - OK, 1 - too many iterations.
%lambda  - vector of Lagrange multipliers.
%res     - residual at solution.
%xx      - iteration trace of x.
%cc      - iteration trace of c.
%ll      - iteration trace of lambda.

% v1.0  1999-11-05. Niclas Borlin, niclas@cs.umu.se.
% v1.1  2000-07-27. Now passes along parameters to functions.
% v1.01 2001-09-20. Made all matrices sparse.

fun=[prob '_f'];
jac=[prob '_j'];
conFun=[con '_c'];
conJac=[con '_a'];

n=0;
x=x0;
code=0;
xx=[];
cc=[];
ll=[];

oldS=[];

M=inv(W);
R=chol(W);

while (1)
	xx=[xx,x];
	% Evaluate functions and jacobians.
	A=feval(conJac,x,params{:});
	J=feval(jac,x,params{:});
	c=feval(conFun,x,params{:});
	cc=[cc,c];
	F=feval(fun,x,params{:});
	b=[-c;-F;zeros(size(x))];
	% Generate system matrix.
	Z1=sparse(size(A,1),size(A,1));
	Z12=sparse(size(A,1),size(J,1));
	Z3=sparse(size(A,2),size(A,2));
	I2=M;
	S=[Z1 Z12 A; Z12' I2 J; A' J' Z3];
	% Solve system matrix.
	pp=sparse(S)\b;
	% Decompose solution vector.
	lambda=pp(1:length(c));
	ll=[ll,lambda];
	res=pp(length(c)+[1:length(F)]);
	p=pp(length(c)+length(F)+[1:length(x)]);
	% Take undamped step.
	x=x+p;
	n=n+1;
	if (norm(R*J*p)<epsf*(1+norm(R*F)) & all(abs(c)<=epsc))
		break;
	end
	if (n>maxIter)
		code=1;
		break;
	end
end

xx=[xx,x];
cc=[cc,feval(conFun,x,params{:})];

