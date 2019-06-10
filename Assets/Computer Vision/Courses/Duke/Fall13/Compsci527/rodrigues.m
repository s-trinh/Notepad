% function rOut = rodrigues(rIn, fussy)
%
% Converts between rotation matrix and rotation angle-axis vector,
% either way. The input must be either a 3x3 matrix or a vector with 3
% entries.
%
% If rIn is a vector:
%   If fussy is true, an error is called if the magnitude of rIn is not
%       in [0, pi].
%   If fussy is false, any value of theta is allowed.
% If rIn is a matrix:
%   If fussy is true, an error is called if rIn does not have determinant 1.
%   If fussy is false, an error is called if rIn has negative determinant.
%       Otherwise, rIn is normalized to have unit determinant.

function rOut = rodrigues(rIn, fussy)


if nargin < 2 || isempty(fussy)
    fussy = true;
end

s = size(rIn);
if length(s) ~= 2
    error('rIn must be a matrix or a vector')
end

if min(s) == 1 && max(s) == 3
    r = rIn(:);
    
    theta = norm(r);
    if theta > pi
        if fussy
            error('Angle of rotation vector must be at most pi')
        else
            theta = mod(theta, 2*pi);
            r = r / norm(r) * theta;
            if theta > pi
                r = - r / norm(r) * (2*pi - theta);
                theta = norm(r);
            end
        end
    end
    
    if theta == 0
        rOut = eye(3);
    else
        u = r / theta;
        cs = cos(theta);
        sn = sin(theta);
        ux = crossPack(u);
        rOut = eye(3) * cs + (1 - cs) * (u * u') + ux * sn;
    end
elseif all(s == 3)
    R = rIn;
    
    % Check that R is approximately a rotation matrix
    small = sqrt(eps);
    d = det(R);
    if (abs(d - 1) > small)
        if fussy
            error('Input matrix must have determinant 1')
        else
            if d > 0
                R = R / d;
            else
                error('Input matrix has zero or negative determinant')
            end
        end
    end
    if (norm(R*R' - eye(3)) > small)
        if fussy
            error('Input matrix must be orthogonal')
        end
    end
    
    % Force R to be a rotation matrix more precisely
    [U, ~, V] = svd(R);
    R = U * V';
    
    % Sine and cosine of the rotation angle
    A = (R - R') / 2;
    rho = crossPack(A);
    sn = norm(rho);
    cs = (trace(R) - 1) / 2;
    
    if sn == 0                       % Rotation angle is either 0 or pi
        tiny = eps * 100;
        if abs(cs - 1) < tiny        % Rotation angle is 0
            rOut = zeros(3, 1);
        elseif abs(cs + 1) < tiny    % Rotation angle is pi
            % Find the column of R + I with greatest norm
            % (for better numerical results)
            Rp = R + eye(3);
            colNorm2 = diag(Rp'*Rp);
            [val, col] = max(colNorm2);
            if val < small          % Shouldn't really happen: R == -eye(3)
                error('R is an inversion, not a rotation')
            end
            v = Rp(:, col);
            u = v / norm(v);
            rOut = pi * hemisphere(u);
        else                        % How can this be?
            error('sin(theta) is zero, bus cos(theta) is neither 1 nor -1!')
        end
    else                            % Rotation strictly between 0 and pi
        u = rho / sn;
        theta = atan2(sn, cs);
        rOut = theta * u;
    end
else
    error('rIn must be a 3 vector or a 3x3 matrix')
end

% -------------------------------------------------------------------------
    function u = hemisphere(u)
        % Changes the sign of a unit vector u so that it is on the proper half of
        % the unit sphere
        
        if (u(1) == 0 && u(2) == 0 && u(3) < 0) || (u(1) == 0 && u(2) < 0) || u(1) < 0
            u = -u;
        end
    end

% -------------------------------------------------------------------------
    function aOut = crossPack(aIn)
        
        % Converts a 3-vector to a skew cross-product matrix, or viceversa
        
        s = size(aIn);
        if length(s) ~= 2
            error('Input must be a 3-vector or a 3x3 matrix')
        elseif min(s) == 1 && max(s) == 3
            a = aIn;
            A = zeros(3);
            A(3, 2) = a(1);
            A(1, 3) = a(2);
            A(2, 1) = a(3);
            A = A - A';
            aOut = A;
        elseif all(s == 3)
            A = aIn;
            small = sqrt(eps);
            if norm(A + A') > small
                error('Input matrix must be skew')
            end
            aOut = [A(3, 2); A(1, 3); A(2, 1)];
        end
    end
end