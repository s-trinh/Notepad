function [lambda,F,M,pp,f,b1,b2,scale,angle]=melendecomp(A)
%MELENDECOMP Decompose the DLT matrix.
%
%Decompose the DLT matrix as described in Melen (1995), "An Ambiguity
%Free Decomposition of the Direct Linear Transformation (DLT) Matrix" in
%Optical 3-D Measurement Techniques III, pp 496-505, Gruen & Kahmen,
%eds., Wichmann-Verlag.
%
%[lambda,F,M,pp,f,b1,b2,scale,angle]=melendecomp(A)
%A      - 3x4 DLT matrix.
%lambda - scale factor.
%F      - focus coordinates.
%M      - rotation matrix.
%pp     - principal point.
%f      - focal distance.
%b1     - x/y axis scaling constant.
%b2     - x/y axis non-orthogonality constant.
%scale  - y/x scaling factor.
%angle  - off-orthogonal angle.

% v1.0  99-11-02. Niclas Borlin, niclas@cs.umu.se.
% v1.01 99-12-08. Corrected documentation bug.
% v1.1  99-12-16. Added calculation of scale factor and off-angle.

% Extract left 3x3 block.
Ap=A(:,1:3);

% Calculate focus position.
F=-Ap\A(:,4);

% Get scaling factor except for sign.
absLambda=norm(Ap(3,:));

% Calculate rq factorization.
[R,Q]=rqfac(Ap/absLambda);

% Modify signs.
correctSigns=[+1,+1,+1]';
J=diag(correctSigns.*sign(diag(R)));
Rp=R*J;

% Get rotation matrix S.
tanTheta=-Rp(1,2)/(Rp(1,1)+Rp(2,2));
sinTheta=tanTheta/sqrt(1+tanTheta^2);
cosTheta=1/sqrt(1+tanTheta^2);
S=eye(3);
S(1:2,1:2)=[cosTheta,sinTheta;-sinTheta,cosTheta];

% Construct G and Mp
G=R*J*S;
Mp=S'*J*Q;

% Move sign from Mp to lambda to make M a rotation matrix.
lambda=absLambda*sign(det(Mp));
M=sign(det(Mp))*Mp;

pp=G(1:2,3);
b1=-(G(1,1)-G(2,2))/(G(1,1)+G(2,2));
b2=-2*G(1,2)/(G(1,1)+G(2,2));
f=2*(G(1,1)*G(2,2)-G(1,2)^2)/(G(1,1)+G(2,2));

scale=sqrt(b2^2+(1-b1)^2)/sqrt((1+b1)^2+b2^2);
angle=atan(2*b2/(b1^2+b2^2-1));