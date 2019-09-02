### Least Squares
- [Least Squares Adjustment: Linear and Nonlinear Weighted Regression Analysis, Allan Aasbjerg Nielsen, Technical University of Denmark](http://www2.imm.dtu.dk/pubdb/views/edoc_download.php/2804/pdf/imm2804.pdf)
- [Nonlinear Least Squares, Rómulo A. Chumacero, February 2006](http://rchumace.econ.uchile.cl/classes/eco1/nlls.pdf)
- [Confidence Intervals for Variances and Standard Deviations](http://www.milefoot.com/math/stat/ci-variances.htm)
- [Lecture 7 - Regularized least-squares and Gauss-Newton method, Stephen Boyd](https://see.stanford.edu/materials/lsoeldsee263/07-ls-reg.pdf)
- [Derivation: The Covariance Matrix of an OLS Estimator (and applications to GLS)](https://theclevermachine.wordpress.com/2013/01/14/derivation-the-covariance-matrix-of-an-ols-estimator-and-applications-to-gls/)
- [Practical Least-Squares for Computer Graphics, Siggraph Course 11](http://graphics.stanford.edu/~jplewis/lscourse/SLIDES.pdf) ([Main course page](http://graphics.stanford.edu/~jplewis/lscourse/))
- [Lecture 4: Multivariate Regression Model in Matrix Form, Takashi Yamano](http://www3.grips.ac.jp/~yamanota/Lecture%20Note%204%20to%207%20OLS.pdf)
- [OLS in Matrix Form (Stanford)](https://web.stanford.edu/~mrosenfe/soc_meth_proj3/matrix_OLS_NYU_notes.pdf)
- [Nonlinear regression, Gordon K. Smyth](https://pdfs.semanticscholar.org/4e6b/470a369c40909d54fe27b2dfe8c39156dfdf.pdf)
- [Least Squares Estimation, Sara A.Van De Geer](https://stat.ethz.ch/~geer/bsa199_o.pdf)
- [OLS in Matrix Form, Nathaniel Beck (University of California, San Diego)](https://web.stanford.edu/~mrosenfe/soc_meth_proj3/matrix_OLS_2_Beck_UCSD.pdf)
- [Chapter 5: The Generalized Linear Regression Model and Heteroscedasticity, Christophe Hurlin (University of Orléans)](https://www.univ-orleans.fr/deg/masters/ESA/CH/Chapter5_GLS.pdf)

### Books
- [Numerical Methods for Least Squares Problems](http://users.mai.liu.se/akebj63/LSPbook.html)

### Covariance
- [Propagation of uncertainty](https://en.wikipedia.org/wiki/Propagation_of_uncertainty)

### Pose covariance
- [How to Project 3D Covariance Matrix to a given Image Plan (Pose)](https://stackoverflow.com/questions/49239473/how-to-project-3d-covariance-matrix-to-a-given-image-plan-pose/49614280#49614280)
- [Uncertainty on pose estimate when minimizing measurement errors](https://stackoverflow.com/questions/36618269/uncertainty-on-pose-estimate-when-minimizing-measurement-errors/36637529#36637529)
- [Transform SE3 pose covariance](https://math.stackexchange.com/questions/1996586/transform-se3-pose-covariance)
- [Jacobian matrix of the Rodrigues' formula (exponential map)](https://math.stackexchange.com/questions/64253/jacobian-matrix-of-the-rodrigues-formula-exponential-map)
- [Minimization on the Lie Group SO(3)](https://math.stackexchange.com/questions/180736/minimization-on-the-lie-group-so3)
- [For the 3D rotation operation 𝑅−1(𝑅(𝜔0)∗𝑅(𝜔)), how can we compute the derivative wrt 𝜔?](https://math.stackexchange.com/questions/3316470/for-the-3d-rotation-operation-r-1r-omega-0r-omega-how-can-we-comput)
- [Jacobian of exponential mapping in SO3/SE3](https://math.stackexchange.com/questions/812563/jacobian-of-exponential-mapping-in-so3-se3)
- [Derivative of exponential mapping of 𝕊𝔼(3) and 𝕊𝕀𝕄(𝟛) in vector/matrix of 𝔰𝔢(3) and 𝔰𝔦𝔪(3).](https://math.stackexchange.com/questions/2077420/derivative-of-exponential-mapping-of-mathbbse3-and-mathbbsim3-in-v)
- [Minimization on the Lie Group SO(3) and Related Manifolds, David J. Kriegman, Published 1994](https://www.semanticscholar.org/paper/Minimization-on-the-Lie-Group-SO(3)-and-Related-Kriegman/0c70e90a16a2a450154a391a28c092fcf6655a34) ([Technical Report](https://www.seas.upenn.edu/~cjtaylor/PUBLICATIONS/pdfs/TaylorTR94b.pdf))
- [A tutorial on SE(3)transformation parameterizationsand on-manifold optimization, José Luis Blanco Claraco](http://ingmec.ual.es/~jlblanco/papers/jlblanco2010geometry3D_techrep.pdf)
- [How to rotate covariance?](https://robotics.stackexchange.com/questions/2556/how-to-rotate-covariance)
- [`mrpt::poses::CPose3DPDFGaussian`](http://mrpt.ual.es/reference/stable/classmrpt_1_1poses_1_1_c_pose3_d_p_d_f_gaussian.html)
- [`quaternionCovFromYawPitchRollCov`](http://www.mira-project.org/MIRA-doc/YawPitchRoll_8h_source.html):
<details><summary>code</summary>
<p>

```
template<typename T>
inline Eigen::Matrix<T,6,6> quaternionCovToYawPitchRollCov(
                                const Eigen::Matrix<T,7,7>& covariance,
                                const Eigen::Quaternion<T>& q)
{
	Eigen::Matrix<T,6,7> J = Eigen::Matrix<T,6,7>::Identity();

	// Generally there exist 3 cases for calculation of yaw, pitch and roll
	// from a quaternion:
	// 1. regular case
	// 2. gimbal lock upwards
	// 3. gimbal lock downwards
	// For these three cases the Jacobian is calculated

	// There exist different methods to calculate the yaw, pitch, roll angle
	// from a quaternion:
	//
	// 1. The current implementation of the Jacobian is build on the calculations
	// of yaw, pitch and roll from Eigen
	//
	// 2. A different calculation is described in the technical report
	// @TECHREPORT{blanco2010se3,
	//	  author = {Blanco, Jos{\'{e}}-Luis},
	//	  month = sep,
	//	  title = {A tutorial on SE(3) transformation parameterizations and on-manifold optimization},
	//	  year = {2010},
	//    institution = {University of Malaga}
	//}
	// http://mapir.isa.uma.es/~jlblanco/papers/jlblanco2010geometry3D_techrep.pdf
	//
	// This calculation is simpler and faster. But since we were not sure, whether
	// it is compatible to the eigen calculation of the yaw, pitch and roll
	// it is uncommented until yet

	// the jacobian of the eigen conversion from quaternion to yaw, pitch, roll
	T a = (T)1.0 - (T)2.0 * (q.x() * q.x() + q.y() * q.y());
	T b = (T)2.0 * (q.y() * q.z() + q.w() * q.x());
	T c = sqrt(a*a + b*b);

	if(c > 1e-3)
	{
		// from eigen quaternionToYawPitchRoll
		// pitch = atan2(-2.0*(q.x()*q.z()-q.w()*q.y()), c)/M_PI*180.0
		// roll  = atan2(2.0*(q.z()*q.y()+q.w()*q.x()), (1.0 - 2.0*(q.x()*q.x()+q.y() * q.y())))/M_PI*180.0
		// yaw   = atan2(2.0 * (q.y() * q.x() + q.z() * q.w()) ,  (1.0 - 2.0*(q.y() * q.y() + q.z() * q.z())))/M_PI*180.0

		T t1 = (T) ((T) q.y() * (T) q.y());
		T t2 = 2 * t1;
		T t3 = (T) q.z() * (T) q.z();
		T t5 = 1 - t2 - 2 * t3;
		T t7 = t5 * t5;
		T t10 = (T) ((T) q.w() * (T) q.z() + (T) q.x() * (T) q.y());
		T t13 = 1 / (t7 + 4 * t10 * t10);
		T t31 = (T) q.x() * (T) q.x();
		T t34 = 1 - 2 * t31 - 2 * t1;
		T t35 = t34 * t34;
		T t38 = (T) q.y() * (T) q.z() + (T) q.w() * (T) q.x();
		T t39 = (T) (t38 * t38);
		T t40 = 4 * t39;
		T t42 = sqrt(t35 + t40);
		T t47 = -(T) q.x() * (T) q.z() + (T) q.w() * (T) q.y();
		T t48 = 2 * t47 * t38;
		T t49 = 1 / t42;
		T t56 = 1 / (t35 + t40 + 4 * t47 * t47);
		T t90 = 1 - 2 * t31 - t2;
		T t92 = t90 * t90;
		T t95 = 1 / (t92 + 4 * t38 * t38);

		J.template block<3,4>(3,3) <<
				2 * q.z() * t5 * t13,
				2 * q.y() * t5 * t13,
				(2 * q.x() * t5 + 8 * t10 * q.y()) * t13,
				(2 * q.w() * t5 + 8 * t10 * q.z()) * t13,

				(2 * (T) q.y() * t42 - 4 * (T) t48 * (T) q.x() * t49) * t56,
				(-2 * (T) q.z() * t42 - (T) t47 * (-8 * t34 * (T) q.x() + 8 * (T) t38 * (T) q.w()) * t49) * t56,
				(2 * (T) q.w() * t42 - (T) t47 * (-8 * t34 * (T) q.y() + 8 * (T) t38 * (T) q.z()) * t49) * t56,
				(-2 * (T) q.x() * t42 - 4 * (T) t48 * (T) q.y() * t49) * t56,

				2 * (T) q.x() * t90 * t95,
				(2 * (T) q.w() * t90 + 8 * t38 * (T) q.x()) * t95,
				(2 * (T) q.z() * t90 + 8 * t38 * (T) q.y()) * t95,
				2 * (T) q.y() * t90 * t95;


		// from technical report
		// pitch = asin(2.0*(q.w()*q.y()-q.x()*q.z())); (differs from eigen)
		// roll  = atan2(2.0*(q.w()*q.x()+q.y()*q.z()), (1.0 - 2.0*(q.x()*q.x()+q.y()*q.y()))); (like eigen)
		// yaw   = atan2(2.0*(q.w()*q.z()+q.x()*q.y()), (1.0 - 2.0*(q.y()*q.y()+q.z()*q.z()))); (like eigen)

		//T t1 = (T) ((T) q.y() * (T) q.y());
		//T t2 = 2 * t1;
		//T t3 = (T) ((T) q.z() * (T) q.z());
		//T t5 = 1 - t2 - 2 * t3;
		//T t7 = t5 * t5;
		//T t10 = (T) ((T) q.w() * (T) q.z() + (T) q.x() * (T) q.y());
		//T t13 = 1 / (t7 + 4 * t10 * t10);
		//T t31 = (T) ((T) q.w() * (T) q.w());
		//T t38 = (T) ((T) q.x() * (T) q.x());
		//T t42 = sqrt((T) (1 - 4 * t31 * t1 + 8 * q.w() * q.y() * q.x() * q.z() - 4 * t38 * t3));
		//T t43 = 0.1e1 / t42;
		//T t53 = 1 - 2 * t38 - t2;
		//T t55 = t53 * t53;
		//T t58 = q.w() * q.x() + q.y() * q.z();
		//T t61 = 1 / (t55 + 4 * t58 * t58);
		//
		//J.template block<3,4>(3,3) <<
		//	2 * q.z() * t5 * t13,
		//	2 * q.y() * t5 * t13,
		//	(2 * q.x() * t5 + 8 * t10 * q.y()) * t13,
		//	(2 * q.w() * t5 + 8 * t10 * q.z()) * t13,
		//	(T) (0.2e1 * (T) q.y() * t43),
		//	-(T) (0.2e1 * (T) q.z() * t43),
		//	(T) (0.2e1 * (T) q.w() * t43),
		//	-(T) (0.2e1 * (T) q.x() * t43),
		//	2 * q.x() * t53 * t61,
		//	(2 * q.w() * t53 + 8 * t58 * q.x()) * t61,
		//	(2 * q.z() * t53 + 8 * t58 * q.y()) * t61,
		//	2 * q.y() * t53 * t61;
	}
	else{

		// for eigen
		T t1 = q.x() * q.x();
		T t3 = q.y() * q.y();
		T t5 = (T)0.10e1 - (T)0.20e1 * t1 - (T)0.20e1 * t3;
		T t6 = t5 * t5;
		T t9 = q.y() * q.z() + q.w() * q.x();
		T t10 = t9 * t9;
		T t11 = (T)0.400e1 * t10;
		T t13 = sqrt(t6 + t11);
		T t16 = q.x() * q.z();
		T t18 = q.w() * q.y();
		T t20 = (T)-0.20e1 * t16 + (T)0.20e1 * t18;
		T t22 = (T)0.1e1 / t13;
		T t27 = t20 * t20;
		T t33 = -t16 + t18;
		T t45 = (T)0.1e1 / (t6 + t11 + (T)0.4e1 * t33 * t33);
		T t67 = (T)0.2e1 * t1;
		T t68 = (T) (q.z() * q.z());
		T t70 = (T)0.1e1 - t67 - (T) (2 * t68);
		T t72 = t70 * t70;
		T t77 = (T)-0.20e1 * q.x() * q.y() + (T)0.20e1 * q.w() * q.z();
		T t78 = t77 * t77;
		T t80 = (T)0.1e1 / (t72 + t78);
		T t96 = (T)0.1e1 - t67 - (T)0.2e1 * t3;
		T t98 = t96 * t96;

		// for technical report
		//T t1 = (T) q.w() * (T) q.w();
		//T t2 = (T) q.x() * (T) q.x();
		//T t4 = 1 / (T) (t1 + t2);

		if(q.x()*q.z() - q.w() * q.y() > 0){
			// from eigen quaternionToYawPitchRoll
			//pitch = atan2(-2.0*(q.x()*q.z()-q.w()*q.y()), c)/M_PI*180.0
			//roll = +atan2(-2.0 * (q.x()*q.y()-q.w() * q.z()), (1.0 - 2.0*(q.x() * q.x() + q.z() * q.z())))/M_PI * 180.0
			//yaw = 0

			J.template block<3,4>(3,3) <<
					0,0,0,0,

					(T) ((0.20e1 * q.y() * t13 - 0.4000000000e1 * t20 * t9 * q.x() * t22) / (t6 + t11 + t27)),
					(T) ((-0.2e1 * q.z() * t13 - t33 * (-0.80e1 * q.x() * t5 + 0.800e1 * t9 * q.w()) * t22) * t45),
					(T) ((0.2e1 * q.w() * t13 - t33 * (-0.80e1 * t5 * q.y() + 0.800e1 * t9 * q.z()) * t22) * t45),
					(T) ((-0.2e1 * q.x() * t13 - 0.8000000000e1 * t33 * t9 * q.y() * t22) * t45),

					(T) (0.20e1 * q.z() * t70 * t80),
					(T) ((-0.20e1 * q.y() * t70 + 0.4e1 * t77 * q.x()) * t80),
					-(T) (0.20e1 * q.x() * t70 / (t72 * t70 + t78)),
					(T) (0.2e1 * q.y() * t96 / (t98 + 0.4e1 * t9 * t9));

			// from technical report
			// pitch = -M_PI/2.0; (differs from eigen)
			// roll  = 0; (differs from eigen)
			// yaw   = 2.0 * atan2(q.x(), q.w()); (differs from eigen)

			//J.template block<3,4>(3,3) <<
			//		-2 * q.x() * t4, 2 * q.w() * t4, 0, 0,
			//		0,0,0,0,
			//		0,0,0,0;
		}
		else{
			// from eigen quaternionToYawPitchRoll
			//pitch = atan2(-2.0*(q.x()*q.z()-q.w()*q.y()), c)/M_PI*180.0
			//roll = -atan2(-2.0 * (q.x()*q.y()-q.w() * q.z()), (1.0 - 2.0*(q.x() * q.x() + q.z() * q.z())))/M_PI * 180.0
			//yaw = 0

			J.template block<3,4>(3,3) <<
					0,0,0,0,

					(T) ((0.20e1 * q.y() * t13 - 0.4000000000e1 * t20 * t9 * q.x() * t22) / (t6 + t11 + t27)),
					(T) ((-0.2e1 * q.z() * t13 - t33 * (-0.80e1 * q.x() * t5 + 0.800e1 * t9 * q.w()) * t22) * t45),
					(T) ((0.2e1 * q.w() * t13 - t33 * (-0.80e1 * t5 * q.y() + 0.800e1 * t9 * q.z()) * t22) * t45),
					(T) ((-0.2e1 * q.x() * t13 - 0.8000000000e1 * t33 * t9 * q.y() * t22) * t45),

					-(T) (0.20e1 * q.z() * t70 * t80),
					-(T) ((-0.20e1 * q.y() * t70 + 0.4e1 * t77 * q.x()) * t80),
					(T) (0.20e1 * q.x() * t70 / (t72 * t70 + t78)),
					-(T) (0.2e1 * q.y() * t96 / (t98 + 0.4e1 * t9 * t9));

			// from technical report
			// pitch = M_PI/2.0; (differs from eigen)
			// roll  = 0; (differs from eigen)
			// yaw   = -2.0 * atan2(q.x(), q.w()); (differs from eigen)

			//J.template block<3,4>(3,3) <<
			//		2 * q.x() * t4, -2 * q.w() * t4, 0, 0,
			//		0,0,0,0,
			//		0,0,0,0;

		}
	}

	return J * covariance * J.transpose();
}
```

</p>
</details>

- [Development of a real-time attitude system using a quaternion parameterization and non-dedicated GPS receivers, John B. Schleppe, Published 1996, https://doi.org/10.11575/PRISM%2F16192](https://www.semanticscholar.org/paper/Development-of-a-real-time-attitude-system-using-a-Schleppe/659b2b955c664965b0fb40a1cbe9d07777e30cda) ([4.6 Covariance Propagation from Quaternions to Euler Angles](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.6.4173&rep=rep1&type=pdf))
- [How do I compute the covariance matrix for an orientation sensor?](https://answers.ros.org/question/9446/how-do-i-compute-the-covariance-matrix-for-an-orientation-sensor/)
- [Covariance matrix for the PoseWithCovariance in Odometry.msg](https://answers.ros.org/question/36848/covariance-matrix-for-the-posewithcovariance-in-odometrymsg/)
- [EE 267 Virtual Reality - Course Notes: 6-DOF Pose Tracking with the VRduino, Gordon Wetzstein](https://stanford.edu/class/ee267/notes/ee267_notes_tracking.pdf)
- [Pose Tracking I, Gordon Wetzstein, Stanford University](https://stanford.edu/class/ee267/lectures/lecture11.pdf)
- [Pose Tracking II, Gordon Wetzstein, Stanford University](https://stanford.edu/class/ee267/lectures/lecture12.pdf)

### Papers
- [Computation of Covariance Matrices for Constrained Parameter Estimation Problem Using LSQR, Ekaterina A. Kostina, Michael A. Saunders, Inga Schierle, Published 2009](https://www.semanticscholar.org/paper/COMPUTATION-OF-COVARIANCE-MATRICES-FOR-CONSTRAINED-Kostina-Saunders/693303eb1027817e4fc999bd00cdfdb0e01626f2) ([pdf](https://web.stanford.edu/group/SOL/reports/SOL-2009-1.pdf))
- [Asymptotic Properties of Non-Linear Least Squares Estimators, Robert I. Jennrich, Published 1969, https://doi.org/10.1214/aoms%2F1177697731](https://www.semanticscholar.org/paper/Asymptotic-Properties-of-Non-Linear-Least-Squares-Jennrich/94d6a5ed17042dfac7a756202bfb019ff84080fb) ([pdf](https://projecteuclid.org/download/pdf_1/euclid.aoms/1177697731))

### Codes
- [Linear Least-Squares Fitting - GSL](https://www.gnu.org/software/gsl/doc/html/lls.html)
