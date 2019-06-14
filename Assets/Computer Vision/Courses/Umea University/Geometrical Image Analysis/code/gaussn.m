function [x,code,n,X,alphas]=gaussn(prob,x0,tol,maxIter,alphaMin,mu,W,params)
%GAUSSN Damped Gauss-Newton method.
%
%[x,code,n,X,alphas]=gaussn(prob,x0,tol,maxIter,alphaMin,mu,W,params)
%prob     - stub name of problem. Residual and jacobian functions are
%           assumed to be called stub_f and stub_j, respectively.
%x0       - starting approximation.
%tol      - convergence tolerance.
%maxiter  - maximum number of iterations.
%alphaMin - shortest accepted step length.
%mu       - constant in Armijo's condition.
%W        - weight matrix. Use W=1 for unweighted problems.
%params   - cell array with additional arguments to residual and jacobian funs.
%x        - optimal solution.
%code     - error code
%              0 - OK
%             -1 - Too many iterations
%             -2 - No acceptable reduction found in line search.
%n        - number of consumed iterations.
%X        - iteration trace. X(:,i+1) is the ith iteration.
%alphas   - vector of accepted step lengths. alphas(i) is the ith step length.

% v1.0  1999-11-09. Niclas Borlin, niclas@cs.umu.se.
% v1.1  2002-05-07. Updated for the '02 course in Geometrical Image Analysis.
% v1.2  2003-05-19. Updated with explicit weights the '03 course in
%                   Geometrical Image Analysis.

x=x0;
X=x;
alphas=[];

n=0;

% Names of problem functions.
fun=[prob '_f'];
jac=[prob '_j'];

% OK until proven otherwise.
code=0;

% Precalculate residual at current point.
F=feval(fun,x,params{:});

% Cholesky ("square root") decomposition of W.
R=chol(W);

while (1)
    % Calculate residual and jacobian at current point.
    J=feval(jac,x,params{:});
    % Gradient.
    g=J'*W*F;
    % Calculate Gauss-Newton search direction.
    p=(R*J)\(R*(-F));
    %Same as p=(J'*W*J)\(-J'*W*F), but numerically better.

    % Terminate if angle between projected residual is smaller than
    % threshold. 
    % A cleaner test would be the strict relative test
    % norm(J*p)>tol*norm(F), but that wouldn't work on synthetic data
    % with norm(F) very small at solution.
    if (norm(R*J*p)<tol*(1+norm(R*F)))
        % Converged.
        break;
    end
    n=n+1;
    if (n>maxIter)
        code=-1; % Too many iterations.
        break;
    end
    % Perform line search along p.
    [alpha,newX,newF]=linesearch(fun,x,p,alphaMin,F,-mu*g'*p,W,params);
    % Always update current point and residual. 
    x=newX;
    F=newF;

    % Store iteration trace and algorithm performance parameters.
    X=[X,x];
    alphas=[alphas alpha];

    if (alpha==0)
        code=-2; % Not sufficient descent.
        break;
    end
end

% Exit.

function [alpha,newx,newF]=linesearch(fun,x,p,alphaMin,oldF,reqRed,W,params)
%LINESEARCH Perform Armijo linesearch with backtracking.
%
%[alpha,newx,newF]=linesearch(fun,x,p,alphaMin,oldF,reqRed,W,params)
%fun      - name of the objective function
%x        - current x value
%p        - current search direction
%alphaMin - shortest step-length allowed
%reqRed   - required reduction of the objective function
%W        - weight matrix.
%params   - additional parameters to the objective function.
%alpha    - first step length that satisfied Armijos condition, or 0 if
%           no such alpha>=alphaMin is found.

% Calculate current objective function value.
f=0.5*oldF'*W*oldF;

% Start with full step length.
alpha=1.0;

% Continue while step length is long enough
while (alpha>=alphaMin)
    % Examine residual at proposed point.
    newx=x+alpha*p;
    newF=feval(fun,newx,params{:});
    newf=0.5*newF'*W*newF;
    
    % Calculate obtained reduction of function value.
    red=f-newf;
    
    if (red>=reqRed*alpha)
        % If reduction is large enough, we're done.
        return;
    else
        % Otherwise, try with half the step length.
        alpha=alpha/2;
    end
end

% No acceptable reduction found. Return alpha=0.
alpha=0;
newx=x;
newF=oldF;
