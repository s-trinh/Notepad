function M=rotmat3d(omega,phi,kappa)
%ROTMAT3D Generate 3d rotation matrix from world to image coordinate systems.
%
%M=rotmat3d(omega,phi,kappa)
%or
%M=rotmat3d([omega,phi,kappa])
%omega - rotation about the x-axis.
%phi   - rotation about the y'-axis.
%kappa - rotation about the z''-axis
%M     - Complete rotation matrix.
%
%All angles are in radians.

% v1.0  99-12-06. Niclas Borlin, niclas@cs.umu.se.

if (nargin==1)
	kappa=omega(3);
	phi=omega(2);
	omega=omega(1);
end

% Generate 2d rotation matrices.
Momega=eye(3);
Momega(2:3,2:3)=rotmat2d(-omega);

Mphi=eye(3);
Mphi([1 3],[1 3])=rotmat2d(phi);

Mkappa=eye(3);
Mkappa(1:2,1:2)=rotmat2d(-kappa);

M=Mkappa*Mphi*Momega;


function M=rotmat2d(phi)
% Create 2d rotation matrix.

M=[cos(phi), -sin(phi);sin(phi), cos(phi)];
