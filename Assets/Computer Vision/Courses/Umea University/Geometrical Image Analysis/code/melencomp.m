function A=melencomp(lambda,F,M,pp,f,b1,b2)
%MELENCOMP Compose the DLT matrix from geometric parameters.
%
%Construct the DLT matrix as described in Melen (1995), "An Ambiguity
%Free Decomposition of the Direct Linear Transformation (DLT) Matrix" in
%Optical 3-D Measurement Techniques III, pp 496-505, Gruen & Kahmen,
%eds., Wichmann-Verlag.
%
%A=melencomp(lambda,F,M,pp,f,b1,b2)
%lambda - scale factor.
%F      - focus coordinates.
%pp     - principal point.
%M      - rotation matrix.
%f      - focal distance.
%b1     - x/y axis scaling constant.
%b2     - x/y axis non-orthogonality constant.
%A      - 3x4 DLT matrix.

% v1.0  99-12-06. Niclas Borlin, niclas@cs.umu.se.
% v1.01 99-12-08. Corrected documentation bug.

V=eye(3);
V(1:2,3)=-pp;
B=eye(3);
B(1:2,1:2)=[1+b1,b2;b2,1-b1];
T=[eye(3),-F];
F=diag([f,f,1]);

A=lambda*(V\(B\(F*M*T)));
