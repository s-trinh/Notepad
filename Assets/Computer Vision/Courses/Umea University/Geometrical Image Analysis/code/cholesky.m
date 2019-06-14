function [R,fail]=cholesky(A)
%CHOLESKY Perform Cholesky factorisation A=RR^T, R upper triangular.
%
%[R,fail]=cholesky(A)
%A    - nxn symmetric positive definite matrix.
%R    - nxn upper triangular matrix such that R*R^T=A
%fail - true if A was not positive definite.

% v1.0  2003-04-07. Niclas Borlin, niclas@cs.umu.se.

[m,n]=size(A);

if (m~=n)
	error('A is not square');
end

R=zeros(n);

fail=0;

if (0)
	% R lower triangular
	for i=1:n
		s=A(i,i)-sum(R(i,1:i-1).^2);
		
		if (s<=0)
			fail=1;
			return;
		end
		
		R(i,i)=sqrt(s);
		
		for j=i+1:n
			s=A(j,i)-sum(R(i,1:i-1).*R(j,1:i-1));
			R(j,i)=s/R(i,i);
		end
	end
else
	% R upper triangular
	for i=n:-1:1
		s=A(i,i)-sum(R(i,i+1:n).^2);

		if (s<=0)
			fail=1;
			return;
		end
		
		R(i,i)=sqrt(s);
		
		for j=i-1:-1:1
			s=A(i,j)-sum(R(i,i+1:n).*R(j,i+1:n));
			R(j,i)=s/R(i,i);
		end
	end
end
