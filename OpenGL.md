### Tutorials
- [Learn OpenGL](https://learnopengl.com/)
- [Learn Computer Graphics From Scratch!](https://www.scratchapixel.com/)
- [OGL dev - Modern OpenGL Tutorials](http://ogldev.atspace.co.uk/)
- [opengl-tutorial](http://www.opengl-tutorial.org/)
- [https://open.gl/](https://open.gl/)
- [An intro to modern OpenGL. Table of Contents](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Table-of-Contents.html)
- [OpenGL (songho.ca)](http://www.songho.ca/opengl/)

### Misc
- [gluLookAt](https://www.khronos.org/registry/OpenGL-Refpages/gl2.1/xhtml/gluLookAt.xml)
- [GluLookAt code](https://www.khronos.org/opengl/wiki/GluLookAt_code)
```
void glhLookAtf2( float *matrix, float *eyePosition3D,
                  float *center3D, float *upVector3D )
{
   float forward[3], side[3], up[3];
   float matrix2[16], resultMatrix[16];
   // --------------------
   forward[0] = center3D[0] - eyePosition3D[0];
   forward[1] = center3D[1] - eyePosition3D[1];
   forward[2] = center3D[2] - eyePosition3D[2];
   NormalizeVector(forward);
   // --------------------
   // Side = forward x up
   ComputeNormalOfPlane(side, forward, upVector3D);
   NormalizeVector(side);
   --------------------
   // Recompute up as: up = side x forward
   ComputeNormalOfPlane(up, side, forward);
   // --------------------
   matrix2[0] = side[0];
   matrix2[4] = side[1];
   matrix2[8] = side[2];
   matrix2[12] = 0.0;
   // --------------------
   matrix2[1] = up[0];
   matrix2[5] = up[1];
   matrix2[9] = up[2];
   matrix2[13] = 0.0;
   // --------------------
   matrix2[2] = -forward[0];
   matrix2[6] = -forward[1];
   matrix2[10] = -forward[2];
   matrix2[14] = 0.0;
   // --------------------
   matrix2[3] = matrix2[7] = matrix2[11] = 0.0;
   matrix2[15] = 1.0;
   // --------------------
   MultiplyMatrices4by4OpenGL_FLOAT(resultMatrix, matrix, matrix2);
   glhTranslatef2(resultMatrix,
                  -eyePosition3D[0], -eyePosition3D[1], -eyePosition3D[2]);
   // --------------------
   memcpy(matrix, resultMatrix, 16*sizeof(float));
}
```
- [Scissor Test](https://www.khronos.org/opengl/wiki/Scissor_Test) ([example](https://github.com/IntelRealSense/librealsense/tree/b0f0f4b4cd6a73f86f27d83ac616db39986ba577/examples/trajectory))
- [how to reset the color in opengl after using glColor4f](https://stackoverflow.com/questions/9259747/how-to-reset-the-color-in-opengl-after-using-glcolor4f/9260276#9260276):
```
glPushAttrib(GL_CURRENT_BIT);
glPopAttrib();
```
- [OpenCV + OpenGL: proper camera pose using solvePnP](http://answers.opencv.org/question/23089/opencv-opengl-proper-camera-pose-using-solvepnp/):
```
cv::Mat rvec, tvec;
cv::solvePnP(objectPoints, imagePoints, intrinsics, distortion, rvec, tvec, ...);
cv::Mat rotation, viewMatrix(4, 4, CV_64F);
cv::Rodrigues(rvec, rotation);

for(unsigned int row=0; row<3; ++row)
{
   for(unsigned int col=0; col<3; ++col)
   {
      viewMatrix.at<double>(row, col) = rotation.at<double>(row, col);
   }
   viewMatrix.at<double>(row, 3) = tvec.at<double>(row, 0);
}
viewMatrix.at<double>(3, 3) = 1.0f;
#
cv::Mat cvToGl = cv::Mat::zeros(4, 4, CV_64F);
cvToGl.at<double>(0, 0) = 1.0f;
cvToGl.at<double>(1, 1) = -1.0f; // Invert the y axis
cvToGl.at<double>(2, 2) = -1.0f; // invert the z axis
cvToGl.at<double>(3, 3) = 1.0f;
viewMatrix = cvToGl * viewMatrix;
#
cv::Mat glViewMatrix = cv::Mat::zeros(4, 4, CV_64F);
cv::transpose(viewMatrix , glViewMatrix);
glMatrixMode(GL_MODELVIEW);
glLoadMatrixd(&glViewMatrix.at<double>(0, 0));
```
- [calculating OpenGL perspective matrix from OpenCV intrinsic matrix ](http://kgeorge.github.io/2014/03/08/calculating-opengl-perspective-matrix-from-opencv-intrinsic-matrix)
- [Calibrated Cameras in OpenGL without glFrustum](http://ksimek.github.io/2013/06/03/calibrated_cameras_in_opengl/)
- [Simulating Calibrated Cameras in OpenGL](https://sightations.wordpress.com/2010/08/03/simulating-calibrated-cameras-in-opengl/)
- [Why does sign matter in opengl projection matrix](https://stackoverflow.com/questions/2286529/why-does-sign-matter-in-opengl-projection-matrix)
- [Unable to Draw 3D (Frustum) on top of 2D (Ortho) in OpenGL](https://stackoverflow.com/questions/5328571/unable-to-draw-3d-frustum-on-top-of-2d-ortho-in-opengl/5328804#5328804)

### Documentation
- [Coordinate Systems](https://learnopengl.com/Getting-started/Coordinate-Systems)
- [An intro to modern OpenGL. Chapter 2.1: Buffers and Textures](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Chapter-2.1:-Buffers-and-Textures.html)
- [glFrustum](https://www.khronos.org/registry/OpenGL-Refpages/gl2.1/xhtml/glFrustum.xml)
- [Avoiding 16 Common OpenGL Pitfalls](https://www.opengl.org/archives/resources/features/KilgardTechniques/oglpitfall/)
- [OpenGL - Common Mistakes](https://www.khronos.org/opengl/wiki/Common_Mistakes)
- [The Perspective and Orthographic Projection Matrix](https://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/opengl-perspective-projection-matrix)
- [Framebuffer Object](https://www.khronos.org/opengl/wiki/Framebuffer_Object)
- [Image Format](https://www.khronos.org/opengl/wiki/Image_Format)

### Sample code
- [OGL_OCV_common.cpp](https://github.com/royshil/HeadPosePnP/blob/master/OGL_OCV_common.cpp)
- [HeadPosePnP](https://github.com/royshil/HeadPosePnP)
- [Head Pose Estimation with OpenCV & OpenGL Revisited [w/ code]](http://www.morethantechnical.com/2012/10/17/head-pose-estimation-with-opencv-opengl-revisited-w-code/):
<details>

```
/*
 *  OGL_OCV_common.cpp
 *  Common interop between OpenCV and OpenGL
 *
 *  Created by Roy Shilkrot on 11/21/11.
 *  Copyright 2011 MIT. All rights reserved.
 *
 */

#include "OGL_OCV_common.h"

void drawOpenCVImageInGL(const OpenCVGLTexture& tex) {
	glDisable(GL_LIGHTING);
	glDisable(GL_BLEND);

	int vPort[4]; glGetIntegerv(GL_VIEWPORT, vPort);

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, tex.tex_id);
	glPushMatrix();
	glColor3ub(255, 255, 255);
	
	glScaled(vPort[3], vPort[3], 1);
	
	double aw2h = tex.aspect_w2h, ithr = tex.thr, itwr = tex.twr;
	double n[3] = {0,0,-1};
	
	GLint face_ori; glGetIntegerv(GL_FRONT_FACE, &face_ori);
	glFrontFace(GL_CW); //we're gonna draw clockwise
	
	glBegin(GL_QUADS);	
	
	glTexCoord2d(0, 0);
	glNormal3dv(n); 
	glVertex2d(0, 0);
	
	glTexCoord2d(0, ithr);
	glNormal3dv(n); 
	glVertex2d(0, 1); 
	
	glTexCoord2d(itwr, ithr);	
	glNormal3dv(n); 
	glVertex2d(aw2h, 1);
	
	glTexCoord2d(itwr, 0);				
	glNormal3dv(n); 
	glVertex2d(aw2h, 0); 
	
	glEnd();
	glPopMatrix();
	
	glFrontFace(face_ori); //restore front face orientation
	
	glDisable(GL_TEXTURE_2D);
	glEnable(GL_LIGHTING);
	glEnable(GL_BLEND);
}

void glEnable2D()
{
	int vPort[4];
	
	glGetIntegerv(GL_VIEWPORT, vPort);
	
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	
	glOrtho(0, vPort[2], 0, vPort[3], -1, 4);
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();
	glTranslated(0.375, 0.375, 0);

	glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT); // clear the screen

	glDisable(GL_DEPTH_TEST);	
}

void glDisable2D()
{
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();   
	glMatrixMode(GL_MODELVIEW);
	glPopMatrix();	
	
	glEnable(GL_DEPTH_TEST);
}

#if defined(WIN32)
#define log2(x) log10((double)(x))/log10(2.0)
#endif

void copyImgToTex(const Mat& _tex_img, GLuint* texID, double* _twr, double* _thr) {
	Mat tex_img = _tex_img;
	flip(_tex_img,tex_img,0);
	Mat tex_pow2(pow(2.0,ceil(log2(tex_img.rows))),pow(2.0,ceil(log2(tex_img.cols))),CV_8UC3);
	std::cout << tex_pow2.rows <<"x"<<tex_pow2.cols<<std::endl;
	Mat region = tex_pow2(Rect(0,0,tex_img.cols,tex_img.rows));
	if (tex_img.type() == region.type()) {
		tex_img.copyTo(region);
	} else if (tex_img.type() == CV_8UC1) {
		cvtColor(tex_img, region, CV_GRAY2BGR);
	} else {
		tex_img.convertTo(region, CV_8UC3, 255.0);
	}
	
	if (_twr != 0 && _thr != 0) {
		*_twr = (double)tex_img.cols/(double)tex_pow2.cols;
		*_thr = (double)tex_img.rows/(double)tex_pow2.rows;
	}
	glBindTexture( GL_TEXTURE_2D, *texID );
	glTexImage2D(GL_TEXTURE_2D, 0, 3, tex_pow2.cols, tex_pow2.rows, 0, GL_BGR, GL_UNSIGNED_BYTE, tex_pow2.data);
}	


OpenCVGLTexture MakeOpenCVGLTexture(const Mat& _tex_img) {
	OpenCVGLTexture _ocvgl;

	glGenTextures( 1, &_ocvgl.tex_id );
	glBindTexture( GL_TEXTURE_2D, _ocvgl.tex_id );
	glTexEnvf( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE );
	glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	
	if (!_tex_img.empty()) { //image may be dummy, just to generate pointer to texture object in GL
		copyImgToTex(_tex_img,&_ocvgl.tex_id,&_ocvgl.twr,&_ocvgl.thr);
		_ocvgl.aspect_w2h = (double)_tex_img.cols/(double)_tex_img.rows;
	}
	
	return _ocvgl;
}
```
</details>

<details>

```
// HeadPose.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include "cv.h"
#include "highgui.h"

using namespace cv;

#include <vector>
#include <iostream>
#include <fstream>

using namespace std;

#if defined(__APPLE__)
#  include <OpenGL/gl.h>
#  include <OpenGL/glu.h>
#elif defined(__linux__) || defined(__MINGW32__) || defined(WIN32)
#  include <GL/gl.h>
#  include <GL/glu.h>
#else
#  include <gl.h>
#endif

#include "glm.h"
#include "OGL_OCV_common.h"

void loadNext();
void loadWithPoints(Mat& ip, Mat& img);

const GLfloat light_ambient[]  = { 0.0f, 0.0f, 0.0f, 1.0f };
const GLfloat light_diffuse[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position[] = { 0.0f, 0.0f, 1.0f, 0.0f };

const GLfloat mat_ambient[]    = { 0.7f, 0.7f, 0.7f, 1.0f };
const GLfloat mat_diffuse[]    = { 0.8f, 0.8f, 0.8f, 1.0f };
const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat high_shininess[] = { 100.0f };

double rot[9] = {0};
GLuint textureID;
Mat backPxls;
vector<double> rv(3), tv(3);
Mat rvec(rv),tvec(tv);
Mat camMatrix;

OpenCVGLTexture imgTex,imgWithDrawing;

GLMmodel* head_obj;

void saveOpenGLBuffer() {
	static unsigned int opengl_buffer_num = 0;
	
	int vPort[4]; glGetIntegerv(GL_VIEWPORT, vPort);
	Mat_<Vec3b> opengl_image(vPort[3],vPort[2]);
	{
		Mat_<Vec4b> opengl_image_4b(vPort[3],vPort[2]);
		glReadPixels(0, 0, vPort[2], vPort[3], GL_BGRA, GL_UNSIGNED_BYTE, opengl_image_4b.data);
		flip(opengl_image_4b,opengl_image_4b,0);
		mixChannels(&opengl_image_4b, 1, &opengl_image, 1, &(Vec6i(0,0,1,1,2,2)[0]), 3);
	}
	stringstream ss; ss << "opengl_buffer_" << opengl_buffer_num++ << ".jpg";
	imwrite(ss.str(), opengl_image);
}


void resize(int width, int height)
{
    const float ar = (float) width / (float) height;

    glViewport(0, 0, width, height);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    //glFrustum(-ar, ar, -1.0, 1.0, 2.0, 100.0);
	gluPerspective(47,1.0,0.01,1000.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int __w=250,__h=250;

void key(unsigned char key, int x, int y)
{

    switch (key)
    {
    case 27 :
    case 'Q':
    case 'q': 
		exit(0);
		break;
	case 'w':
	case 'W':
		__w++;
		__w = __w%251;
		break;
	case 'h':
	case 'H':
		__h++;
		__h = __h%250;
		break;
	case ' ':
			saveOpenGLBuffer();
		loadNext();
		break;
    default:
        break;
    }

    glutPostRedisplay();
}

void idle(void)
{
    glutPostRedisplay();
}



void myGLinit() {
//    glutSetOption ( GLUT_ACTION_ON_WINDOW_CLOSE, GLUT_ACTION_CONTINUE_EXECUTION ) ;

	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
	

	glShadeModel(GL_SMOOTH);

    glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);
	
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glEnable(GL_LIGHT0);
    glEnable(GL_NORMALIZE);
    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial ( GL_FRONT, GL_AMBIENT_AND_DIFFUSE );

    glLightfv(GL_LIGHT0, GL_AMBIENT,  light_ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE,  light_diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);

    glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
    glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
    glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);

	glEnable(GL_LIGHTING);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
}

void drawAxes() {
	
	//Z = red
	glPushMatrix();
	glRotated(180,0,1,0);
	glColor4d(1,0,0,0.5);
//	glutSolidCylinder(0.05,1,15,20);
    glBegin(GL_LINES);
    glVertex3d(0, 0, 0); glVertex3d(0, 0, 1);
    glEnd();
	glTranslated(0,0,1);
	glScaled(.1,.1,.1);
	glutSolidTetrahedron();
	glPopMatrix();
	
	//Y = green
	glPushMatrix();
	glRotated(-90,1,0,0);
	glColor4d(0,1,0,0.5);
//	glutSolidCylinder(0.05,1,15,20);
    glBegin(GL_LINES);
    glVertex3d(0, 0, 0); glVertex3d(0, 0, 1);
    glEnd();
	glTranslated(0,0,1);
	glScaled(.1,.1,.1);
	glutSolidTetrahedron();
	glPopMatrix();
	
	//X = blue
	glPushMatrix();
	glRotated(-90,0,1,0);
	glColor4d(0,0,1,0.5);
//	glutSolidCylinder(0.05,1,15,20);
    glBegin(GL_LINES);
    glVertex3d(0, 0, 0); glVertex3d(0, 0, 1);
    glEnd();
	glTranslated(0,0,1);
	glScaled(.1,.1,.1);
	glutSolidTetrahedron();
	glPopMatrix();
}	

void display(void)
{	
	// draw the image in the back
	int vPort[4]; glGetIntegerv(GL_VIEWPORT, vPort);
	glEnable2D();
	drawOpenCVImageInGL(imgTex);
	glTranslated(vPort[2]/2.0, 0, 0);
	drawOpenCVImageInGL(imgWithDrawing);
	glDisable2D();

	glClear(GL_DEPTH_BUFFER_BIT); // we want to draw stuff over the image
	
	// draw only on left part
	glViewport(0, 0, vPort[2]/2, vPort[3]);
	
	glPushMatrix();
	
	gluLookAt(0,0,0,0,0,1,0,-1,0);

	// put the object in the right position in space
	Vec3d tvv(tv[0],tv[1],tv[2]);
	glTranslated(tvv[0], tvv[1], tvv[2]);

	// rotate it
	double _d[16] = {	rot[0],rot[1],rot[2],0,
						rot[3],rot[4],rot[5],0,
						rot[6],rot[7],rot[8],0,
						0,	   0,	  0		,1};
	glMultMatrixd(_d);
	
	// draw the 3D head model
	glColor4f(1, 1, 1,0.75);
	glmDraw(head_obj, GLM_SMOOTH);

	//----------Axes
	glScaled(50, 50, 50);
	drawAxes();
	//----------End axes

	glPopMatrix();
	
	// restore to looking at complete viewport
	glViewport(0, 0, vPort[2], vPort[3]); 

	glutSwapBuffers();
}

void init_opengl(int argc,char** argv) {
	glutInitWindowSize(500,250);
    glutInitWindowPosition(40,40);
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH); // | GLUT_MULTISAMPLE
    glutCreateWindow("head pose");
	
	myGLinit();
	
    glutReshapeFunc(resize);
    glutDisplayFunc(display);
    glutKeyboardFunc(key);
    //glutSpecialFunc(special);
    glutIdleFunc(idle);
}	

int start_opengl() {

    glutMainLoop();

	return 1;
}

Mat op;

void loadNext() {
	static int counter = 1;
	
	printf("load %d\n",counter);
    
    const char* workingDir = "./";

	char buf[256] = {0};
	sprintf(buf,"%sAngelina_Jolie/Angelina_Jolie_%04d.txt",workingDir,counter);

	vector<Point2f > imagePoints;
	ifstream inputfile(buf);
	if(inputfile.fail()) { 
		cerr << "can't read " << buf << endl; return; 
	}

	for(int i=0;i<7;i++) {
		int x=0,y=0;
		inputfile >> skipws >> x >> y;
		imagePoints.push_back(Point2f((float)x,(float)y));
	}
	inputfile.close();

	Mat ip(imagePoints);
	
	sprintf(buf,"%sAngelina_Jolie/Angelina_Jolie_%04d.jpg",workingDir,counter);

	Mat img = imread(buf);

	imgTex.set(img); //TODO: what if different size??

	// paint 2D feature points
	for(unsigned int i=0;i<imagePoints.size();i++) circle(img,imagePoints[i],2,Scalar(255,0,255),CV_FILLED);

	loadWithPoints(ip,img);
	
	imgWithDrawing.set(img);
	
	counter = (counter+1);
}

void loadWithPoints(Mat& ip, Mat& img) {
	int max_d = MAX(img.rows,img.cols);
	camMatrix = (Mat_<double>(3,3) << max_d, 0, img.cols/2.0,
										0,	max_d, img.rows/2.0,
										0,	0,	1.0);
	cout << "using cam matrix " << endl << camMatrix << endl;
	
	double _dc[] = {0,0,0,0};
	solvePnP(op,ip,camMatrix,Mat(1,4,CV_64FC1,_dc),rvec,tvec,false,CV_EPNP);

	Mat rotM(3,3,CV_64FC1,rot);
	Rodrigues(rvec,rotM);
	double* _r = rotM.ptr<double>();
	printf("rotation mat: \n %.3f %.3f %.3f\n%.3f %.3f %.3f\n%.3f %.3f %.3f\n",
		_r[0],_r[1],_r[2],_r[3],_r[4],_r[5],_r[6],_r[7],_r[8]);

	printf("trans vec: \n %.3f %.3f %.3f\n",tv[0],tv[1],tv[2]);

	double _pm[12] = {_r[0],_r[1],_r[2],tv[0],
					  _r[3],_r[4],_r[5],tv[1],
					  _r[6],_r[7],_r[8],tv[2]};

	Matx34d P(_pm);
	Mat KP = camMatrix * Mat(P);
//	cout << "KP " << endl << KP << endl;

	//reproject object points - check validity of found projection matrix
	for (int i=0; i<op.rows; i++) {
		Mat_<double> X = (Mat_<double>(4,1) << op.at<float>(i,0),op.at<float>(i,1),op.at<float>(i,2),1.0);
//		cout << "object point " << X << endl;
		Mat_<double> opt_p = KP * X;
		Point2f opt_p_img(opt_p(0)/opt_p(2),opt_p(1)/opt_p(2));
//		cout << "object point reproj " << opt_p_img << endl; 
		
		circle(img, opt_p_img, 4, Scalar(0,0,255), 1);
	}
	rotM = rotM.t();// transpose to conform with majorness of opengl matrix
}


int main(int argc, char** argv)
{

	vector<Point3f > modelPoints;
//	modelPoints.push_back(Point3f(-36.9522f,39.3518f,47.1217f));	//l eye
//	modelPoints.push_back(Point3f(35.446f,38.4345f,47.6468f));		//r eye
//	modelPoints.push_back(Point3f(-0.0697709f,18.6015f,87.9695f)); //nose
//	modelPoints.push_back(Point3f(-27.6439f,-29.6388f,73.8551f));	//l mouth
//	modelPoints.push_back(Point3f(28.7793f,-29.2935f,72.7329f));	//r mouth
//	modelPoints.push_back(Point3f(-87.2155f,15.5829f,-45.1352f));	//l ear
//	modelPoints.push_back(Point3f(85.8383f,14.9023f,-46.3169f));	//r ear
	//new model points: 
	modelPoints.push_back(Point3f(2.37427,110.322,21.7776));	// l eye (v 314)
	modelPoints.push_back(Point3f(70.0602,109.898,20.8234));	// r eye (v 0)
	modelPoints.push_back(Point3f(36.8301,78.3185,52.0345));	//nose (v 1879)
	modelPoints.push_back(Point3f(14.8498,51.0115,30.2378));	// l mouth (v 1502)
	modelPoints.push_back(Point3f(58.1825,51.0115,29.6224));	// r mouth (v 695)
	modelPoints.push_back(Point3f(-61.8886,127.797,-89.4523));	// l ear (v 2011)
	modelPoints.push_back(Point3f(127.603,126.9,-83.9129));		// r ear (v 1138)
	
	head_obj = glmReadOBJ("head-obj.obj");

	op = Mat(modelPoints);
	Scalar m = mean(Mat(modelPoints));
	//op = op - m;
	
	//assert(norm(mean(op)) < 1e-05); //make sure is centered
	
	//op = op + Scalar(0,0,25);
	
	cout << "model points " << op << endl;
	
	rvec = Mat(rv);
	double _d[9] = {1,0,0,
					0,-1,0,
					0,0,-1};
	Rodrigues(Mat(3,3,CV_64FC1,_d),rvec);
	tv[0]=0;tv[1]=0;tv[2]=1;
	tvec = Mat(tv);
	
	camMatrix = Mat(3,3,CV_64FC1);

	init_opengl(argc, argv); // get GL context, for loading textures

	// prepare OpenCV-OpenGL images
	imgTex = MakeOpenCVGLTexture(Mat());
	imgWithDrawing = MakeOpenCVGLTexture(Mat());

	loadNext();

	start_opengl();

	return 0;
}
```
</details>

- [Camera pose using OpenCV and OpenGL](https://rdmilligan.wordpress.com/2015/10/05/camera-pose-using-opencv-and-opengl/) ([Camera position in world coordinate from cv::solvePnP](https://stackoverflow.com/questions/18637494/camera-position-in-world-coordinate-from-cvsolvepnp)):
<details>

```
from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *
import cv2
from PIL import Image
import numpy as np
from webcam import Webcam
from glyphs import *
 
class OpenGLGlyphs:
 
    # constants
    INVERSE_MATRIX = np.array([[ 1.0, 1.0, 1.0, 1.0],
                               [-1.0,-1.0,-1.0,-1.0],
                               [-1.0,-1.0,-1.0,-1.0],
                               [ 1.0, 1.0, 1.0, 1.0]])
  
    def __init__(self):
        # initialise webcam and start thread
        self.webcam = Webcam()
        self.webcam.start()
 
        # textures
        self.texture_background = None
        self.texture_cube = None
 
    def _init_gl(self, Width, Height):
        glClearColor(0.0, 0.0, 0.0, 0.0)
        glClearDepth(1.0)
        glDepthFunc(GL_LESS)
        glEnable(GL_DEPTH_TEST)
        glShadeModel(GL_SMOOTH)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(33.7, 1.3, 0.1, 100.0)
        glMatrixMode(GL_MODELVIEW)
         
        # enable textures
        glEnable(GL_TEXTURE_2D)
        self.texture_background = glGenTextures(1)
        self.texture_cube = glGenTextures(1)
 
        # create cube texture 
        image = Image.open("devil.jpg")
        ix = image.size[0]
        iy = image.size[1]
        image = image.tostring("raw", "RGBX", 0, -1)
 
        glBindTexture(GL_TEXTURE_2D, self.texture_cube)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
        glTexImage2D(GL_TEXTURE_2D, 0, 3, ix, iy, 0, GL_RGBA, GL_UNSIGNED_BYTE, image)
 
    def _draw_scene(self):
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        glLoadIdentity()
 
        # get image from webcam
        image = self.webcam.get_current_frame()
 
        # convert image to OpenGL texture format
        bg_image = cv2.flip(image, 0)
        bg_image = Image.fromarray(bg_image)     
        ix = bg_image.size[0]
        iy = bg_image.size[1]
        bg_image = bg_image.tostring("raw", "BGRX", 0, -1)
  
        # create background texture
        glBindTexture(GL_TEXTURE_2D, self.texture_background)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
        glTexImage2D(GL_TEXTURE_2D, 0, 3, ix, iy, 0, GL_RGBA, GL_UNSIGNED_BYTE, bg_image)
         
        # draw background
        glBindTexture(GL_TEXTURE_2D, self.texture_background)
        glPushMatrix()
        glTranslatef(0.0,0.0,-10.0)
        self._draw_background()
        glPopMatrix()
 
        # handle glyph
        image = self._handle_glyph(image)
 
        glutSwapBuffers()
 
    def _handle_glyph(self, image):
 
        # attempt to detect glyph
        rvecs = None
        tvecs = None
 
        try:
            rvecs, tvecs = detect_glyph(image)
        except Exception as ex: 
            print(ex)
 
        if rvecs == None or tvecs == None: 
            return
 
        # build view matrix
        rmtx = cv2.Rodrigues(rvecs)[0]
 
        view_matrix = np.array([[rmtx[0][0],rmtx[0][1],rmtx[0][2],tvecs[0]],
                                [rmtx[1][0],rmtx[1][1],rmtx[1][2],tvecs[1]],
                                [rmtx[2][0],rmtx[2][1],rmtx[2][2],tvecs[2]],
                                [0.0       ,0.0       ,0.0       ,1.0    ]])
 
        view_matrix = view_matrix * self.INVERSE_MATRIX
 
        view_matrix = np.transpose(view_matrix)
 
        # load view matrix and draw cube
        glBindTexture(GL_TEXTURE_2D, self.texture_cube)
        glPushMatrix()
        glLoadMatrixd(view_matrix)
        self._draw_cube()
        glPopMatrix()
 
    def _draw_cube(self):
        # draw cube
        glBegin(GL_QUADS)
 
        glTexCoord2f(0.0, 0.0); glVertex3f( 0.0,  0.0,  0.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 1.0,  0.0,  0.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0,  0.0)
        glTexCoord2f(0.0, 1.0); glVertex3f( 0.0,  1.0,  0.0)
 
        glTexCoord2f(1.0, 0.0); glVertex3f( 0.0,  0.0, -1.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 0.0,  1.0, -1.0)
        glTexCoord2f(0.0, 1.0); glVertex3f( 1.0,  1.0, -1.0)
        glTexCoord2f(0.0, 0.0); glVertex3f( 1.0,  0.0, -1.0)
 
        glTexCoord2f(0.0, 1.0); glVertex3f( 0.0,  1.0, -1.0)
        glTexCoord2f(0.0, 0.0); glVertex3f( 0.0,  1.0,  0.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 1.0,  1.0,  0.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0, -1.0)
 
        glTexCoord2f(1.0, 1.0); glVertex3f( 0.0,  0.0, -1.0)
        glTexCoord2f(0.0, 1.0); glVertex3f( 1.0,  0.0, -1.0)
        glTexCoord2f(0.0, 0.0); glVertex3f( 1.0,  0.0,  0.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 0.0,  0.0,  0.0)
 
        glTexCoord2f(1.0, 0.0); glVertex3f( 1.0,  0.0, -1.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 1.0,  1.0, -1.0)
        glTexCoord2f(0.0, 1.0); glVertex3f( 1.0,  1.0,  0.0)
        glTexCoord2f(0.0, 0.0); glVertex3f( 1.0,  0.0,  0.0)
 
        glTexCoord2f(0.0, 0.0); glVertex3f( 0.0,  0.0, -1.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 0.0,  0.0,  0.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 0.0,  1.0,  0.0)
        glTexCoord2f(0.0, 1.0); glVertex3f( 0.0,  1.0, -1.0)
 
        glEnd()
 
    def _draw_background(self):
        # draw background
        glBegin(GL_QUADS)
        glTexCoord2f(0.0, 1.0); glVertex3f(-4.0, -3.0, 0.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 4.0, -3.0, 0.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 4.0,  3.0, 0.0)
        glTexCoord2f(0.0, 0.0); glVertex3f(-4.0,  3.0, 0.0)
        glEnd( )
 
    def main(self):
        # setup and run OpenGL
        glutInit()
        glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
        glutInitWindowSize(640, 480)
        glutInitWindowPosition(800, 400)
        self.window_id = glutCreateWindow("OpenGL Glyphs")
        glutDisplayFunc(self._draw_scene)
        glutIdleFunc(self._draw_scene)
        self._init_gl(640, 480)
        glutMainLoop()
  
# run an instance of OpenGL Glyphs 
openGLGlyphs = OpenGLGlyphs()
openGLGlyphs.main()
```
</details>

- [Matching calibrated cameras with OpenGL](http://jamesgregson.blogspot.com/2011/11/matching-calibrated-cameras-with-opengl.html):
<details>

```
/**
 @brief basic function to produce an OpenGL projection matrix and associated viewport parameters
 which match a given set of camera intrinsics. This is currently written for the Eigen linear
 algebra library, however it should be straightforward to port to any 4x4 matrix class.
 @param[out] frustum Eigen::Matrix4d projection matrix.  Eigen stores these matrices in column-major (i.e. OpenGL) order.
 @param[out] viewport 4-component OpenGL viewport values, as might be retrieved by glGetIntegerv( GL_VIEWPORT, &viewport[0] )
 @param[in]  alpha x-axis focal length, from camera intrinsic matrix
 @param[in]  alpha y-axis focal length, from camera intrinsic matrix
 @param[in]  skew  x and y axis skew, from camera intrinsic matrix
 @param[in]  u0 image origin x-coordinate, from camera intrinsic matrix
 @param[in]  v0 image origin y-coordinate, from camera intrinsic matrix
 @param[in]  img_width image width, in pixels
 @param[in]  img_height image height, in pixels
 @param[in]  near_clip near clipping plane z-location, can be set arbitrarily > 0, controls the mapping of z-coordinates for OpenGL
 @param[in]  far_clip  far clipping plane z-location, can be set arbitrarily > near_clip, controls the mapping of z-coordinate for OpenGL
*/
void build_opengl_projection_for_intrinsics( Eigen::Matrix4d &frustum, int *viewport, double alpha, double beta, double skew, double u0, double v0, int img_width, int img_height, double near_clip, double far_clip ){
     
    // These parameters define the final viewport that is rendered into by
    // the camera.
    double L = 0;
    double R = img_width;
    double B = 0;
    double T = img_height;
     
    // near and far clipping planes, these only matter for the mapping from
    // world-space z-coordinate into the depth coordinate for OpenGL
    double N = near_clip;
    double F = far_clip;
     
    // set the viewport parameters
    viewport[0] = L;
    viewport[1] = B;
    viewport[2] = R-L;
    viewport[3] = T-B;
     
    // construct an orthographic matrix which maps from projected
    // coordinates to normalized device coordinates in the range
    // [-1, 1].  OpenGL then maps coordinates in NDC to the current
    // viewport
    Eigen::Matrix4d ortho = Eigen::Matrix4d::Zero();
    ortho(0,0) =  2.0/(R-L); ortho(0,3) = -(R+L)/(R-L);
    ortho(1,1) =  2.0/(T-B); ortho(1,3) = -(T+B)/(T-B);
    ortho(2,2) = -2.0/(F-N); ortho(2,3) = -(F+N)/(F-N);
    ortho(3,3) =  1.0;
     
    // construct a projection matrix, this is identical to the 
    // projection matrix computed for the intrinsicx, except an
    // additional row is inserted to map the z-coordinate to
    // OpenGL. 
    Eigen::Matrix4d tproj = Eigen::Matrix4d::Zero();
    tproj(0,0) = alpha; tproj(0,1) = skew; tproj(0,2) = u0;
                        tproj(1,1) = beta; tproj(1,2) = v0;
                                           tproj(2,2) = -(N+F); tproj(2,3) = -N*F;
                                           tproj(3,2) = 1.0;
     
    // resulting OpenGL frustum is the product of the orthographic
    // mapping to normalized device coordinates and the augmented
    // camera intrinsic matrix
    frustum = ortho*tproj;
}
#
#
glMatrixMode(GL_PROJECTION);
glLoadMatrixd( &frustum(0,0) );
```
</details>

- [Chapter 4. Camera Models and Augmented Reality](https://www.oreilly.com/library/view/programming-computer-vision/9781449341916/ch04.html) ([Programming Computer Vision with Python By Jan Erik Solem](http://programmingcomputervision.com/downloads/ProgrammingComputerVision_CCdraft.pdf)):

<details>

```
# Projecting 3D Points
from scipy import linalg

class Camera(object):
  """ Class for representing pin-hole cameras. """

  def __init__(self,P):
    """ Initialize P = K[R|t] camera model. """
    self.P = P
    self.K = None # calibration matrix
    self.R = None # rotation
    self.t = None # translation
    self.c = None # camera center


  def project(self,X):
    """  Project points in X (4*n array) and normalize coordinates. """

    x = dot(self.P,X)
    for i in range(3):
      x[i] /= x[2]
    return x
#
import camera

# load points
points = loadtxt('house.p3d').T
points = vstack((points,ones(points.shape[1])))

# setup camera
P = hstack((eye(3),array([[0],[0],[-10]])))
cam = camera.Camera(P)
x = cam.project(points)

# plot projection
figure()
plot(x[0],x[1],'k.')
show()
#
# create transformation
r = 0.05*random.rand(3)
rot = camera.rotation_matrix(r)

# rotate camera and project
figure()
for t in range(20):
  cam.P = dot(cam.P,rot)
  x = cam.project(points)
  plot(x[0],x[1],'k.')
show()
#
def rotation_matrix(a):
  """  Creates a 3D rotation matrix for rotation
    around the axis of the vector a. """
  R = eye(4)
  R[:3,:3] = linalg.expm([[0,-a[2],a[1]],[a[2],0,-a[0]],[-a[1],a[0],0]])
  return R
#
# Factoring the Camera Matrix
def factor(self):
  """  Factorize the camera matrix into K,R,t as P = K[R|t]. """

  # factor first 3*3 part
  K,R = linalg.rq(self.P[:,:3])

  # make diagonal of K positive
  T = diag(sign(diag(K)))
  if linalg.det(T) < 0:
    T[1,1] *= -1

  self.K = dot(K,T)
  self.R = dot(T,R) # T is its own inverse
  self.t = dot(linalg.inv(self.K),self.P[:,3])

  return self.K, self.R, self.t
#
import camera

K = array([[1000,0,500],[0,1000,300],[0,0,1]])
tmp = camera.rotation_matrix([0,0,1])[:3,:3]
Rt = hstack((tmp,array([[50],[40],[30]])))
cam = camera.Camera(dot(K,Rt))

print K,Rt
print cam.factor()
#
# Computing the Camera Center
def center(self):
  """  Compute and return the camera center. """

  if self.c is not None:
    return self.c
  else:
    # compute c by factoring
    self.factor()
    self.c = -dot(self.R.T,self.t)
    return self.c
#
# A Simple Calibration Method
def my_calibration(sz):
  row,col = sz
  fx = 2555*col/2592
  fy = 2586*row/1936
  K = diag([fx,fy,1])
  K[0,2] = 0.5*col
  K[1,2] = 0.5*row
  return K
#
# 4.3 Pose Estimation from Planes and Markers
import homography
import camera
import sift

# compute features
sift.process_image('book_frontal.JPG','im0.sift')
l0,d0 = sift.read_features_from_file('im0.sift')

sift.process_image('book_perspective.JPG','im1.sift')
l1,d1 = sift.read_features_from_file('im1.sift')

# match features and estimate homography
matches = sift.match_twosided(d0,d1)
ndx = matches.nonzero()[0]
fp = homography.make_homog(l0[ndx,:2].T)
ndx2 = [int(matches[i]) for i in ndx]
tp = homography.make_homog(l1[ndx2,:2].T)

model = homography.RansacModel()
H = homography.H_from_ransac(fp,tp,model)
#
def cube_points(c,wid):
  """  Creates a list of points for plotting
    a cube with plot. (the first 5 points are
    the bottom square, some sides repeated). """
  p = []
  # bottom
  p.append([c[0]-wid,c[1]-wid,c[2]-wid])
  p.append([c[0]-wid,c[1]+wid,c[2]-wid])
  p.append([c[0]+wid,c[1]+wid,c[2]-wid])
  p.append([c[0]+wid,c[1]-wid,c[2]-wid])
  p.append([c[0]-wid,c[1]-wid,c[2]-wid]) # same as first to close plot

  # top
  p.append([c[0]-wid,c[1]-wid,c[2]+wid])
  p.append([c[0]-wid,c[1]+wid,c[2]+wid])
  p.append([c[0]+wid,c[1]+wid,c[2]+wid])
  p.append([c[0]+wid,c[1]-wid,c[2]+wid])
  p.append([c[0]-wid,c[1]-wid,c[2]+wid]) # same as first to close plot

  # vertical sides
  p.append([c[0]-wid,c[1]-wid,c[2]+wid])
  p.append([c[0]-wid,c[1]+wid,c[2]+wid])
  p.append([c[0]-wid,c[1]+wid,c[2]-wid])
  p.append([c[0]+wid,c[1]+wid,c[2]-wid])
  p.append([c[0]+wid,c[1]+wid,c[2]+wid])
  p.append([c[0]+wid,c[1]-wid,c[2]+wid])
  p.append([c[0]+wid,c[1]-wid,c[2]-wid])

  return array(p).T
#
# camera calibration
K = my_calibration((747,1000))

# 3D points at plane z=0 with sides of length 0.2
box = cube_points([0,0,0.1],0.1)

# project bottom square in first image
cam1 = camera.Camera( hstack((K,dot(K,array([[0],[0],[-1]])) )) )
# first points are the bottom square
box_cam1 = cam1.project(homography.make_homog(box[:,:5]))

# use H to transfer points to the second image
box_trans = homography.normalize(dot(H,box_cam1))

# compute second camera matrix from cam1 and H
cam2 = camera.Camera(dot(H,cam1.P))
A = dot(linalg.inv(K),cam2.P[:,:3])
A = array([A[:,0],A[:,1],cross(A[:,0],A[:,1])]).T
cam2.P[:,:3] = dot(K,A)

# project with the second camera
box_cam2 = cam2.project(homography.make_homog(box))


# test: projecting point on z=0 should give the same
point = array([1,1,0,1]).T
print homography.normalize(dot(dot(H,cam1.P),point))
print cam2.project(point)
#im0 = array(Image.open('book_frontal.JPG'))
im1 = array(Image.open('book_perspective.JPG'))

# 2D projection of bottom square
figure()
imshow(im0)
plot(box_cam1[0,:],box_cam1[1,:],linewidth=3)

# 2D projection transferred with H
figure()
imshow(im1)
plot(box_trans[0,:],box_trans[1,:],linewidth=3)

# 3D cube
figure()
imshow(im1)
plot(box_cam2[0,:],box_cam2[1,:],linewidth=3)

show()
#
import pickle

with open('ar_camera.pkl','w') as f:
  pickle.dump(K,f)
  pickle.dump(dot(linalg.inv(K),cam2.P),f)
#
# From Camera Matrix to OpenGL Format
def set_projection_from_camera(K):
  """  Set view from a camera calibration matrix. """

  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()

  fx = K[0,0]
  fy = K[1,1]
  fovy = 2*arctan(0.5*height/fy)*180/pi
  aspect = (width*fy)/(height*fx)

  # define the near and far clipping planes
  near = 0.1
  far = 100.0

  # set perspective
  gluPerspective(fovy,aspect,near,far)
  glViewport(0,0,width,height)
#
def set_modelview_from_camera(Rt):
  """  Set the model view matrix from camera pose. """

  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()

  # rotate teapot 90 deg around x-axis so that z-axis is up
  Rx = array([[1,0,0],[0,0,-1],[0,1,0]])

  # set rotation to best approximation
  R = Rt[:,:3]
  U,S,V = linalg.svd(R)
  R = dot(U,V)
  R[0,:] = -R[0,:] # change sign of x-axis

  # set translation
  t = Rt[:,3]

  # setup 4*4 model view matrix
  M = eye(4)
  M[:3,:3] = dot(R,Rx)
  M[:3,3] = t

  # transpose and flatten to get column order
  M = M.T
  m = M.flatten()

  # replace model view with the new matrix
  glLoadMatrixf(m)
#
# Placing Virtual Objects in the Image
def draw_background(imname):
  """  Draw background image using a quad. """

  # load background image (should be .bmp) to OpenGL texture
  bg_image = pygame.image.load(imname).convert()
  bg_data = pygame.image.tostring(bg_image,"RGBX",1)

  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  # bind the texture
  glEnable(GL_TEXTURE_2D)
  glBindTexture(GL_TEXTURE_2D,glGenTextures(1))
  glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,bg_data)
  glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
  glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST)

  # create quad to fill the whole window
  glBegin(GL_QUADS)
  glTexCoord2f(0.0,0.0); glVertex3f(-1.0,-1.0,-1.0)
  glTexCoord2f(1.0,0.0); glVertex3f( 1.0,-1.0,-1.0)
  glTexCoord2f(1.0,1.0); glVertex3f( 1.0, 1.0,-1.0)
  glTexCoord2f(0.0,1.0); glVertex3f(-1.0, 1.0,-1.0)
  glEnd()

  # clear the texture
  glDeleteTextures(1)
#
def draw_teapot(size):
  """ Draw a red teapot at the origin. """
  glEnable(GL_LIGHTING)
  glEnable(GL_LIGHT0)
  glEnable(GL_DEPTH_TEST)
  glClear(GL_DEPTH_BUFFER_BIT)

  # draw red teapot
  glMaterialfv(GL_FRONT,GL_AMBIENT,[0,0,0,0])
  glMaterialfv(GL_FRONT,GL_DIFFUSE,[0.5,0.0,0.0,0.0])
  glMaterialfv(GL_FRONT,GL_SPECULAR,[0.7,0.6,0.6,0.0])
  glMaterialf(GL_FRONT,GL_SHININESS,0.25*128.0)
  glutSolidTeapot(size)
#
# Tying It All Together
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *
import pygame, pygame.image
from pygame.locals import *
import pickle

width,height = 1000,747

def setup():
  """ Setup window and pygame environment. """
  pygame.init()
  pygame.display.set_mode((width,height),OPENGL | DOUBLEBUF)
  pygame.display.set_caption('OpenGL AR demo')

# load camera data
with open('ar_camera.pkl','r') as f:
  K = pickle.load(f)
  Rt = pickle.load(f)

setup()
draw_background('book_perspective.bmp')
set_projection_from_camera(K)
set_modelview_from_camera(Rt)
draw_teapot(0.02)

while True:
  event = pygame.event.poll()
  if event.type in (QUIT,KEYDOWN):
    break
  pygame.display.flip()
#
# Loading Models
def load_and_draw_model(filename):
  """  Loads a model from an .obj file using objloader.py.
    Assumes there is a .mtl material file with the same name. """
  glEnable(GL_LIGHTING)
  glEnable(GL_LIGHT0)
  glEnable(GL_DEPTH_TEST)
  glClear(GL_DEPTH_BUFFER_BIT)

  # set model color
  glMaterialfv(GL_FRONT,GL_AMBIENT,[0,0,0,0])
  glMaterialfv(GL_FRONT,GL_DIFFUSE,[0.5,0.75,1.0,0.0])
  glMaterialf(GL_FRONT,GL_SHININESS,0.25*128.0)

  # load from a file
  import objloader
  obj = objloader.OBJ(filename,swapyz=True)
  glCallList(obj.gl_list)
```
</details>

- [Set background image of an openGL window](https://stackoverflow.com/questions/8249282/set-background-image-of-an-opengl-window/8249441#8249441):

<details>
	
```
# Part 1: Vertex buffers
void TestDraw(){
    // create a vertex buffer (This is a buffer in video memory)
    GLuint my_vertex_buffer;
    glGenBuffers(1 /*ask for one buffer*/, &my_vertex_buffer);

    const float a_2d_triangle[] =
    {
        200.0f, 10.0f,
        10.0f, 200.0f,
        400.0f, 200.0f
    };

    // GL_ARRAY_BUFFER indicates we're using this for 
    // vertex data (as opposed to things like feedback, index, or texture data)
    // so this call says use my_vertex_data as the vertex data source
    // this will become relevant as we make draw calls later 
    glBindBuffer(GL_ARRAY_BUFFER, my_vertex_buffer);


    // allocate some space for our buffer

    glBufferData(GL_ARRAY_BUFFER, 4096, NULL, GL_DYNAMIC_DRAW);

    // we've been a bit optimistic, asking for 4k of space even 
    // though there is only one triangle.
    // the NULL source indicates that we don't have any data 
    // to fill the buffer quite yet.
    // GL_DYNAMIC_DRAW indicates that we intend to change the buffer
    // data from frame-to-frame.
    // the idea is that we can place more than 3(!) vertices in the
    // buffer later as part of normal drawing activity

    // now we actually put the vertices into the buffer.
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(a_2d_triangle), a_2d_triangle);
#
# Part 2: Vertex Array Object:
    GLuint my_vao;
    glGenVertexArrays(1, &my_vao);

    //lets use the VAO we created
    glBindVertexArray(my_vao);

    // now we need to tell the VAO how the vertices in my_vertex_buffer
    // are structured
    // our vertices are really simple: each one has 2 floats of position data
    // they could have been more complicated (texture coordinates, color -- 
    // whatever you want)

    // enable the first attribute in our VAO
    glEnableVertexAttribArray(0);

    // describe what the data for this attribute is like
    glVertexAttribPointer(0, // the index we just enabled
        2, // the number of components (our two position floats) 
        GL_FLOAT, // the type of each component
        false, // should the GL normalize this for us?
        2 * sizeof(float), // number of bytes until the next component like this
        (void*)0); // the offset into our vertex buffer where this element starts
#
# Part 3: Shaders
    // first create some ids
    GLuint my_shader_program = glCreateProgram();
    GLuint my_fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
    GLuint my_vertex_shader = glCreateShader(GL_VERTEX_SHADER);

    // we'll need to compile the vertex shader and fragment shader
    // and then link them into a full "shader program"
    // load one string from &my_fragment_source
    // the NULL indicates that the string is null-terminated
    const char* my_fragment_source = FragmentSourceFromSomewhere();
    glShaderSource(my_fragment_shader, 1, &my_fragment_source, NULL);
    // now compile it:
    glCompileShader(my_fragment_shader);

    // then check the result
    GLint compiled_ok;
    glGetShaderiv(my_fragment_shader, GL_COMPILE_STATUS, &compiled_ok);
    if (!compiled_ok){ printf("Oh Noes, fragment shader didn't compile!\n"); }
    else{
        glAttachShader(my_shader_program, my_fragment_shader);
    }

    // and again for the vertex shader
    const char* my_vertex_source = VertexSourceFromSomewhere();
    glShaderSource(my_vertex_shader, 1, &my_vertex_source, NULL);
    glCompileShader(my_vertex_shader);
    glGetShaderiv(my_vertex_shader, GL_COMPILE_STATUS, &compiled_ok);
    if (!compiled_ok){ printf("Oh Noes, vertex shader didn't compile!\n"); }
    else{
        glAttachShader(my_shader_program, my_vertex_shader);
    }

    //finally, link the program, and set it active
    glLinkProgram(my_shader_program);
    glUseProgram(my_shader_program);
#
# Part 4: Drawing things on the screen
//get the screen size
    float my_viewport[4];
    glGetFloatv(GL_VIEWPORT, my_viewport);

    //now create a projection matrix
    float my_proj_matrix[16];
    MyOrtho2D(my_proj_matrix, 0.0f, my_viewport[2], my_viewport[3], 0.0f);

    //"uProjectionMatrix" refers directly to the variable of that name in 
    // shader source
    GLuint my_projection_ref = 
        glGetUniformLocation(my_shader_program, "uProjectionMatrix");

    // send our projection matrix to the shader
    glUniformMatrix4fv(my_projection_ref, 1, GL_FALSE, my_proj_matrix );


    //clear the background
    glClearColor(0.3, 0.4, 0.4, 1.0);
    glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);

    // *now* after that tiny setup, we're ready to draw the best 24 bytes of
    // vertex data ever.

    // draw the 3 vertices starting at index 0, interpreting them as triangles
    glDrawArrays(GL_TRIANGLES, 0, 3);

    // now just swap buffers however your window manager lets you
}
#
# Shaders
const char* VertexSourceFromSomewhere()
{
    return
        "#version 330\n"
        "layout(location = 0) in vec2 inCoord;\n"
        "uniform mat4 uProjectionMatrix;\n"
        "void main()\n"
        "{\n"
        "    gl_Position = uProjectionMatrix*(vec4(inCoord, 0, 1.0));\n"
        "}\n";
}

const char* FragmentSourceFromSomewhere()
{
    return
        "#version 330 \n"
        "out vec4 outFragColor;\n"
        "vec4 DebugMagenta(){ return vec4(1.0, 0.0, 1.0, 1.0); }\n"
        "void main() \n"
        "{\n"
        "   outFragColor = DebugMagenta();\n"
        "}\n";
}
#
# Orthographic Projection
void MyOrtho2D(float* mat, float left, float right, float bottom, float top)
{
    // this is basically from
    // http://en.wikipedia.org/wiki/Orthographic_projection_(geometry)
    const float zNear = -1.0f;
    const float zFar = 1.0f;
    const float inv_z = 1.0f / (zFar - zNear);
    const float inv_y = 1.0f / (top - bottom);
    const float inv_x = 1.0f / (right - left);

    //first column
    *mat++ = (2.0f*inv_x);
    *mat++ = (0.0f);
    *mat++ = (0.0f);
    *mat++ = (0.0f);

    //second
    *mat++ = (0.0f);
    *mat++ = (2.0*inv_y);
    *mat++ = (0.0f);
    *mat++ = (0.0f);

    //third
    *mat++ = (0.0f);
    *mat++ = (0.0f);
    *mat++ = (-2.0f*inv_z);
    *mat++ = (0.0f);

    //fourth
    *mat++ = (-(right + left)*inv_x);
    *mat++ = (-(top + bottom)*inv_y);
    *mat++ = (-(zFar + zNear)*inv_z);
    *mat++ = (1.0f);
}
```
</details>

- [OpenGL: fastest way to draw 2d image](https://stackoverflow.com/questions/30488155/opengl-fastest-way-to-draw-2d-image/30498068#30498068):
<details>

```
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, 512, 512, 0,
             GL_RGBA, GL_UNSIGNED_BYTE, NULL);
#
glTexStorage2D(GL_TEXTURE_2D, 1, GL_RGBA8, 512, 512);
#
glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 512, 512,
                GL_RGBA, GL_UNSIGNED_BYTE, data);
#
// One time during setup.
GLuint readFboId = 0;
glGenFramebuffers(1, &readFboId);
glBindFramebuffer(GL_READ_FRAMEBUFFER, readFboId);
glFramebufferTexture2D(GL_READ_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                       GL_TEXTURE_2D, tex, 0);
glBindFramebuffer(GL_READ_FRAMEBUFFER, 0);

// Every time you want to copy the texture to the default framebuffer.
glBindFramebuffer(GL_READ_FRAMEBUFFER, readFboId);
glBlitFramebuffer(0, 0, texWidth, texHeight,
                  0, 0, winWidth, winHeight,
                  GL_COLOR_BUFFER_BIT, GL_LINEAR);
glBindFramebuffer(GL_READ_FRAMEBUFFER, 0);
```
</details>

- [Drawing a 2D texture in OpenGL [closed]](https://stackoverflow.com/questions/24262264/drawing-a-2d-texture-in-opengl/24266568#24266568):
<details>

```
#include <GL/glut.h>
#include <GL/gl.h>
#include <stdio.h>

int main(int argc, char** argv)
{
    //create GL context
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA);
    glutInitWindowSize(800, 600);
    glutCreateWindow("windowname");

    //create test checker image
    unsigned char texDat[64];
    for (int i = 0; i < 64; ++i)
        texDat[i] = ((i + (i / 8)) % 2) * 128 + 127;

    //upload to GPU texture
    GLuint tex;
    glGenTextures(1, &tex);
    glBindTexture(GL_TEXTURE_2D, tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, 8, 8, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, texDat);
    glBindTexture(GL_TEXTURE_2D, 0);

    //match projection to window resolution (could be in reshape callback)
    glMatrixMode(GL_PROJECTION);
    glOrtho(0, 800, 0, 600, -1, 1);
    glMatrixMode(GL_MODELVIEW);

    //clear and draw quad with texture (could be in display callback)
    glClear(GL_COLOR_BUFFER_BIT);
    glBindTexture(GL_TEXTURE_2D, tex);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    glTexCoord2i(0, 0); glVertex2i(100, 100);
    glTexCoord2i(0, 1); glVertex2i(100, 500);
    glTexCoord2i(1, 1); glVertex2i(500, 500);
    glTexCoord2i(1, 0); glVertex2i(500, 100);
    glEnd();
    glDisable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, 0);
    glFlush(); //don't need this with GLUT_DOUBLE and glutSwapBuffers

    getchar(); //pause so you can see what just happened
    //System("pause"); //I think this works on windows

    return 0;
}
```
</details>

- [https://github.com/rdmilligan/SaltwashAR/blob/master/scripts/main.py](https://github.com/rdmilligan/SaltwashAR/blob/master/scripts/main.py):
<details>

```
# Copyright (C) 2015 Ross D Milligan
# GNU GENERAL PUBLIC LICENSE Version 3 (full notice can be found at https://github.com/rdmilligan/SaltwashAR)

from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *
import cv2
from PIL import Image
import numpy as np
from configprovider import ConfigProvider
from robot import *
from webcam import Webcam
from markers import Markers
from features import Features
from constants import *

class SaltwashAR:
 
    # constants
    INVERSE_MATRIX = np.array([[ 1.0, 1.0, 1.0, 1.0],
                               [-1.0,-1.0,-1.0,-1.0],
                               [-1.0,-1.0,-1.0,-1.0],
                               [ 1.0, 1.0, 1.0, 1.0]])

    def __init__(self):
        # initialise config
        self.config_provider = ConfigProvider()

        # initialise robots
        self.rocky_robot = RockyRobot()
        self.sporty_robot = SportyRobot()

        # initialise webcam
        self.webcam = Webcam()

        # initialise markers
        self.markers = Markers()
        self.markers_cache = None

        # initialise features
        self.features = Features(self.config_provider)

        # initialise texture
        self.texture_background = None

    def _init_gl(self):
        glClearColor(0.0, 0.0, 0.0, 0.0)
        glClearDepth(1.0)
        glDepthFunc(GL_LESS)
        glEnable(GL_DEPTH_TEST)
        glShadeModel(GL_SMOOTH)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(33.7, 1.3, 0.1, 100.0)
        glMatrixMode(GL_MODELVIEW)

        # load robots frames
        self.rocky_robot.load_frames(self.config_provider.animation)
        self.sporty_robot.load_frames(self.config_provider.animation)

        # start webcam thread
        self.webcam.start()

        # assign texture
        glEnable(GL_TEXTURE_2D)
        self.texture_background = glGenTextures(1)

    def _draw_scene(self):
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        glLoadIdentity()

        # reset robots
        self.rocky_robot.reset()
        self.sporty_robot.reset()

        # get image from webcam
        image = self.webcam.get_current_frame()

        # handle background
        self._handle_background(image.copy())

        # handle markers
        self._handle_markers(image.copy())
       
        # handle features
        self.features.handle(self.rocky_robot, self.sporty_robot, image.copy())

        glutSwapBuffers()

    def _handle_background(self, image):
        
        # let features update background image
        image = self.features.update_background_image(image)

        # convert image to OpenGL texture format
        bg_image = cv2.flip(image, 0)
        bg_image = Image.fromarray(bg_image)     
        ix = bg_image.size[0]
        iy = bg_image.size[1]
        bg_image = bg_image.tobytes('raw', 'BGRX', 0, -1)
 
        # create background texture
        glBindTexture(GL_TEXTURE_2D, self.texture_background)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
        glTexImage2D(GL_TEXTURE_2D, 0, 3, ix, iy, 0, GL_RGBA, GL_UNSIGNED_BYTE, bg_image)
        
        # draw background
        glBindTexture(GL_TEXTURE_2D, self.texture_background)
        glPushMatrix()
        glTranslatef(0.0,0.0,-10.0)
        glBegin(GL_QUADS)
        glTexCoord2f(0.0, 1.0); glVertex3f(-4.0, -3.0, 0.0)
        glTexCoord2f(1.0, 1.0); glVertex3f( 4.0, -3.0, 0.0)
        glTexCoord2f(1.0, 0.0); glVertex3f( 4.0,  3.0, 0.0)
        glTexCoord2f(0.0, 0.0); glVertex3f(-4.0,  3.0, 0.0)
        glEnd( )
        glPopMatrix()

    def _handle_markers(self, image):

        # attempt to detect markers
        markers = []

        try:
            markers = self.markers.detect(image)
        except Exception as ex:
            print(ex)

        # manage markers cache
        if markers:
            self.markers_cache = markers
        elif self.markers_cache: 
            markers = self.markers_cache
            self.markers_cache = None
        else:
            return

        for marker in markers:
            
            rvecs, tvecs, marker_rotation, marker_name = marker

            # build view matrix
            rmtx = cv2.Rodrigues(rvecs)[0]

            view_matrix = np.array([[rmtx[0][0],rmtx[0][1],rmtx[0][2],tvecs[0]],
                                    [rmtx[1][0],rmtx[1][1],rmtx[1][2],tvecs[1]],
                                    [rmtx[2][0],rmtx[2][1],rmtx[2][2],tvecs[2]],
                                    [0.0       ,0.0       ,0.0       ,1.0    ]])

            view_matrix = view_matrix * self.INVERSE_MATRIX

            view_matrix = np.transpose(view_matrix)

            # load view matrix and draw cube
            glPushMatrix()
            glLoadMatrixd(view_matrix)

            if marker_name == ROCKY_ROBOT:
                self.rocky_robot.next_frame(marker_rotation, self.features.is_speaking(), self.features.get_emotion())
            elif marker_name == SPORTY_ROBOT:
                self.sporty_robot.next_frame(marker_rotation, self.features.is_speaking(), self.features.get_emotion())

            glColor3f(1.0, 1.0, 1.0)
            glPopMatrix()

    def main(self):
        # setup and run OpenGL
        glutInit()
        glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
        glutInitWindowSize(640, 480)
        glutInitWindowPosition(100, 100)
        glutCreateWindow('SaltwashAR')
        glutDisplayFunc(self._draw_scene)
        glutIdleFunc(self._draw_scene)
        self._init_gl()
        glutMainLoop()
 
# run an instance of SaltwashAR
saltwashAR = SaltwashAR()
saltwashAR.main()
```
</details>

- [Augmented Reality using OpenCV and OpenGL](https://rdmilligan.wordpress.com/2015/09/10/augmented-reality-using-opencv-and-opengl/)
- [OpenCV-OpenGL-AugmentedReality](https://github.com/DineshKannan/OpenCV-OpenGL-AugmentedReality):
<details>

```
#include"stdafx.h"
#include <cstdio>
#include <iostream>
#include <fstream>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <vector>
#include "glut.h"      
#include "GL/glu.h"    
#include "GL/gl.h"   
#include <math.h>
#include <time.h>

using namespace std;     
using namespace cv;

const float zNear = 0.05;			
const float zFar = 500.0;
int width,height;
int draw=0;
Point FIX_X(0,0),FIX_Y(0,0),FIX_Z(0,0);
float skew_x,skew_y,skew_z;
VideoCapture cap(0);
Mat tmp,test;
Mat intrinsic_Matrix(3,3, CV_64F);
Mat distortion_coeffs(8,1, CV_64F);
Mat Projection(4,4, CV_64FC1);
double largest_area;
int largest_contour_index;
int n=0; 
int no_of_fingers=0;
vector<vector<pair<float,Point>>> position;
vector<int> finger_count;
Point first,second,third;
float size_of_pot=10;
int rot_angle=10;

float distanceP2P(Point a, Point b){
	float d= sqrt(fabs( pow(a.x-b.x,2) + pow(a.y-b.y,2) )) ;  
	return d;
}
float getAngle(Point s, Point f, Point e){
	float l1 = distanceP2P(f,s);
	float l2 = distanceP2P(f,e);
	float dot=(s.x-f.x)*(e.x-f.x) + (s.y-f.y)*(e.y-f.y);
	float angle = acos(dot/(l1*l2));
	angle=angle*180/3.147;
	return angle;
}


String intToString(int number){
	stringstream ss;
	ss << number;
	string str = ss.str();
	return str;
}

bool pairCompare(const pair<float,Point>&i, const pair<float,Point>&j) {
	return i.first <j.first;

}

GLfloat* convertMatrixType(const cv::Mat& m)
{
	typedef double precision;

	Size s = m.size();
	GLfloat* mGL = new GLfloat[s.width*s.height];

	for(int ix = 0; ix < s.width; ix++)
	{
		for(int iy = 0; iy < s.height; iy++)
		{
			mGL[ix*s.height + iy] = m.at<precision>(iy, ix);
		}
	}

	return mGL;
}

void generateProjectionModelview(const cv::Mat& calibration, const cv::Mat& rotation, const cv::Mat& translation, cv::Mat& projection, cv::Mat& modelview)
{
	typedef double precision;

	projection.at<precision>(0,0) = 2*calibration.at<precision>(0,0)/width;
	projection.at<precision>(1,0) = 0;
	projection.at<precision>(2,0) = 0;
	projection.at<precision>(3,0) = 0;

	projection.at<precision>(0,1) = 0;
	projection.at<precision>(1,1) = 2*calibration.at<precision>(1,1)/height;
	projection.at<precision>(2,1) = 0;
	projection.at<precision>(3,1) = 0;

	projection.at<precision>(0,2) = 1-2*calibration.at<precision>(0,2)/width;
	projection.at<precision>(1,2) = -1+(2*calibration.at<precision>(1,2)+2)/height;
	projection.at<precision>(2,2) = (zNear+zFar)/(zNear - zFar);
	projection.at<precision>(3,2) = -1;

	projection.at<precision>(0,3) = 0;
	projection.at<precision>(1,3) = 0;
	projection.at<precision>(2,3) = 2*zNear*zFar/(zNear - zFar);
	projection.at<precision>(3,3) = 0;


	modelview.at<precision>(0,0) = rotation.at<precision>(0,0);
	modelview.at<precision>(1,0) = rotation.at<precision>(1,0);
	modelview.at<precision>(2,0) = rotation.at<precision>(2,0);
	modelview.at<precision>(3,0) = 0;

	modelview.at<precision>(0,1) = rotation.at<precision>(0,1);
	modelview.at<precision>(1,1) = rotation.at<precision>(1,1);
	modelview.at<precision>(2,1) = rotation.at<precision>(2,1);
	modelview.at<precision>(3,1) = 0;

	modelview.at<precision>(0,2) = rotation.at<precision>(0,2);
	modelview.at<precision>(1,2) = rotation.at<precision>(1,2);
	modelview.at<precision>(2,2) = rotation.at<precision>(2,2);
	modelview.at<precision>(3,2) = 0;

	modelview.at<precision>(0,3) = translation.at<precision>(0,0);
	modelview.at<precision>(1,3) = translation.at<precision>(1,0);
	modelview.at<precision>(2,3) = translation.at<precision>(2,0);
	modelview.at<precision>(3,3) = 1;

	// This matrix corresponds to the change of coordinate systems.
	static double changeCoordArray[4][4] = {{1, 0, 0, 0}, {0, -1, 0, 0}, {0, 0, -1, 0}, {0, 0, 0, 1}};
	static Mat changeCoord(4, 4, CV_64FC1, changeCoordArray);

	modelview = changeCoord*modelview;
}


void calibrate(Mat &intrinsic_Matrix,Mat &distortion_coeffs)
{

	vector< vector< Point2f> > AllimagePoints;
	vector< vector< Point3f> > AllobjectPoints;
	char str[100];
	stringstream st;
	int no_of_images=1;
	Size imagesize;
	Mat gray;
	while(no_of_images<=14)
	{
		st<<"E:/SelectedImages/Selected"<<++no_of_images<<".jpg";
		String strcopy3=st.str();
		st.str("");
		Mat img=imread(strcopy3,1);
		if(!img.data)
			break;
		imagesize=Size(img.rows,img.cols);
		cvtColor(img, gray, CV_RGB2GRAY);
		vector< Point2f> corners;  
		bool sCorner =false;
		sCorner=findChessboardCorners(gray, Size(7,7), corners);
		if(sCorner)
		{

			cornerSubPix(gray, corners, Size(11,11), Size(-1,-1), TermCriteria(CV_TERMCRIT_EPS+CV_TERMCRIT_ITER, 30, 0.1));
			drawChessboardCorners(img, Size(7,7), corners, sCorner);
			if(corners.size() == 7*7)
			{
				vector< Point2f> v_tImgPT;
				vector< Point3f> v_tObjPT;
				for(int j=0; j< corners.size(); ++j)
				{
					Point2f tImgPT;
					Point3f tObjPT;

					tImgPT.x = corners[j].x;
					tImgPT.y = corners[j].y;

					tObjPT.x = j%7*3;
					tObjPT.y = j/7*3;
					tObjPT.z = 0;

					v_tImgPT.push_back(tImgPT);
					v_tObjPT.push_back(tObjPT);     
				}
				AllimagePoints.push_back(v_tImgPT);
				AllobjectPoints.push_back(v_tObjPT);
			}

		}
		st<<"E:/DetectedImages/Detected"<<no_of_images+1<<".jpg";
		String strcopy1=st.str();
		st.str("");
		imwrite(strcopy1,img);
		//imshow("pattern",img);
		//cvWaitKey(30);
	}
	vector< Mat> rvecs, tvecs;
	if(AllimagePoints.size()>0)
	{
		calibrateCamera(AllobjectPoints,AllimagePoints,imagesize, intrinsic_Matrix, distortion_coeffs, rvecs, tvecs);
	}

}


void renderBackgroundGL(const cv::Mat& image)
{
	
	GLint polygonMode[2];
	glGetIntegerv(GL_POLYGON_MODE, polygonMode);
	glPolygonMode(GL_FRONT, GL_FILL);
	glPolygonMode(GL_BACK, GL_FILL);

	
	glLoadIdentity();
	gluOrtho2D(0.0, 1.0, 0.0, 1.0);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	
	static bool textureGenerated = false;
	static GLuint textureId;
	if (!textureGenerated)
	{
		glGenTextures(1, &textureId);

		glBindTexture(GL_TEXTURE_2D, textureId);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

		textureGenerated = true;
	}

	// Copy the image to the texture.
	glBindTexture(GL_TEXTURE_2D, textureId);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, image.size().width, image.size().height, 0, GL_BGR_EXT, GL_UNSIGNED_BYTE, image.data);

	// Draw the image.
	glEnable(GL_TEXTURE_2D);
	glBegin(GL_TRIANGLES);
	glNormal3f(0.0, 0.0, 1.0);

	glTexCoord2f(0.0, 1.0);
	glVertex3f(0.0, 0.0, 0.0);
	glTexCoord2f(0.0, 0.0);
	glVertex3f(0.0, 1.0, 0.0);
	glTexCoord2f(1.0, 1.0);
	glVertex3f(1.0, 0.0, 0.0);

	glTexCoord2f(1.0, 1.0);
	glVertex3f(1.0, 0.0, 0.0);
	glTexCoord2f(0.0, 0.0);
	glVertex3f(0.0, 1.0, 0.0);
	glTexCoord2f(1.0, 0.0);
	glVertex3f(1.0, 1.0, 0.0);
	glEnd();
	glDisable(GL_TEXTURE_2D);

	// Clear the depth buffer so the texture forms the background.
	glClear(GL_DEPTH_BUFFER_BIT);

	// Restore the polygon mode state.
	glPolygonMode(GL_FRONT, polygonMode[0]);
	glPolygonMode(GL_BACK, polygonMode[1]);
}




void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);	
	namedWindow("live",1);
	Mat gray1,test,modelview,dis_img,thresh,img1;

	Mat rvec(3,1,DataType<double>::type);
	Mat tvec(3,1,DataType<double>::type);

	modelview.create(4, 4, CV_64FC1);
	//Projection.create(4, 4, CV_64FC1);

	vector< Point2f> corners1;  
	vector< Point2f> imagePoints1;
	vector< Point3f> objectPoints1;
	largest_area=0;
	largest_contour_index=0;

	clock_t clock_1 = clock();
	cap >> dis_img;
	//resize(dis_img,dis_img,Size(180,180),0,0);
	if(!dis_img.data)
	{
		exit(3);
	}
	img1=dis_img.clone();
	dis_img.copyTo(img1);	
	//resize(img1,img1,Size(180,180),0,0);
	cvtColor(dis_img,dis_img,COLOR_BGR2YCrCb);
	inRange(dis_img,Scalar(0,133,77),Scalar(255,173,127),thresh);
	clock_t clock_2 = clock();
	cout<<"threshold(Skin Color Segmentation) time is :"<<(double)(clock_2-clock_1)<<endl;
	dilate(thresh,thresh,Mat());
	blur(thresh,thresh,Size(5,5),Point(-1,-1),BORDER_DEFAULT);
	vector<vector<Point>> contours;
	vector<Point> FingerTips;
	vector<Vec4i> hierachy; 
	vector<Vec4i> defects;
	vector<Point> defect_circle;
	vector<vector<Point>> hull(1);
	Point2f  center;
	float radius;
	clock_t clock_3 = clock();
	cout<<"image filtering (smoothing) time is :"<<(double)(clock_3-clock_2)<<endl;
	

	findContours(thresh,contours,hierachy,CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE );
	//cout<<"contour"<<endl; 
	int cont_size=contours.size();
	for(int i=0;i<cont_size;i++)
	{
		double a=contourArea(contours[i],false);
		if(a>largest_area)
		{
			largest_area=a;
			largest_contour_index=i;
		}
	}

	vector<int> hull_index;
	Rect brect;

	if(largest_area>0 && contours[largest_contour_index].size()>5)
	{

		approxPolyDP(contours[largest_contour_index],contours[largest_contour_index],8,true);
		//cout<<"approx_poly"<<endl;
		convexHull(Mat(contours[largest_contour_index]),hull[0],false,true);
		//	cout<<"convex_hull"<<endl;
		brect=boundingRect(contours[largest_contour_index]);
		//cout<<"bounding_rect"<<endl;
		convexHull(Mat(contours[largest_contour_index]),hull_index,true);
		//cout<<"convex_hull2"<<endl;
		convexityDefects(contours[largest_contour_index], hull_index, defects);
		//cout<<"convexity defect"<<endl;
		// Mom ents mom=moments(contours[largest_contour_index]);
		// draw mass center
		//	circle(img,Point(mom.m10/mom.m00,mom.m01/mom.m00),2,cv::Scalar(0),2);


		Scalar colorw = Scalar(0,255,0);
		Scalar color1 = Scalar(0,0,255);
		//drawContours(img,contours,largest_contour_index,color,2, 8, hierachy);
		//drawContours(timg,contours,largest_contour_index,color,1, 8, hierachy);
		//drawContours(timg, hull, 0, color1, 1, 8, vector<Vec4i>(), 0, Point() );
		//	drawContours(img, hull, 0, color1, 2, 8, vector<Vec4i>(), 0, Point() );
		int defc_size=defects.size();

		Point ptStart;
		Point ptEnd;
		Point ptStart2;
		Point ptEnd2;
		Point ptFar;
		int count=1;
		int startidx2;
		int endidx2;
		int tolerance =  brect.height/5;
		float angleTol=95;
		for(int in=0;in<defc_size;in++)
		{
			//Vec4i& v=(*d); d++;
			int startidx=defects[in].val[0];ptStart=contours[largest_contour_index].at(startidx);
			int endidx=defects[in].val[1]; ptEnd=contours[largest_contour_index].at(endidx);
			int faridx=defects[in].val[2];  ptFar=contours[largest_contour_index].at(faridx);
			if(in+1<defc_size)
				startidx2=defects[in+1].val[0];ptStart=contours[largest_contour_index].at(startidx);
			endidx2=defects[in+1].val[1]; ptEnd=contours[largest_contour_index].at(endidx);

			if(distanceP2P(ptStart, ptFar) > tolerance && distanceP2P(ptEnd, ptFar) > tolerance && getAngle(ptStart, ptFar, ptEnd  ) < angleTol ){
				{
					if(in+1<defc_size)
					{
						if(distanceP2P(ptStart,ptEnd2) < tolerance )
							contours[largest_contour_index][startidx]=ptEnd2;
						else{
							if(distanceP2P(ptEnd,ptStart2) < tolerance )
								contours[largest_contour_index][startidx2]=ptEnd;

						}
					}
					defect_circle.push_back(ptFar);
				//	cout<<"ptfar"<<ptFar.x<<"&&"<<ptFar.y<<endl;

					if(count==1) 
					{
						FingerTips.push_back(ptStart);
						cv::circle(img1, ptStart,   2, Scalar(0,255,0 ), 2 );
						putText(img1,intToString(count),ptStart-Point(0,30),FONT_HERSHEY_PLAIN, 1.2f,Scalar(255,0,0),2);
					}
					FingerTips.push_back(ptEnd);
					count++;
					putText(img1,intToString(count),ptEnd-Point(0,30),FONT_HERSHEY_PLAIN, 1.2f,Scalar(255,0,0),2);
					cv::circle(img1, ptEnd,   2, Scalar(0,255,0 ), 2 );
					//cv::circle( img, ptFar,   2, Scalar(255,255,255 ), 2 );

				}
			}
		}
		//  circle(img, ptStart,2,Scalar(0xFF,0x60,0x02 ), 2, 8, 0 );

		//cv::circle( img, ptEnd,   4, Scalar( 0xFF,0x60,0x02 ), 2 );
			clock_t clock_4 = clock();
	cout<<"fingerTip detection  time is :"<<(double)(clock_4-clock_3)<<endl;

	//	cout<<"hii"<<endl;
		bool two_fn=false;
		bool five_fn=false;

		if(defect_circle.size()==1)
		{
			 two_fn=true;
			Point fn=FingerTips.back();
			FingerTips.pop_back();
			Point ln=FingerTips.back();
			FingerTips.pop_back();
			Point defect_point=defect_circle.back();
			float curr=getAngle(fn,defect_point,ln);
			curr=curr/10;
			curr=10-curr;
			renderBackgroundGL(img1);
				objectPoints1.push_back(Point3d(9,6,0));
			imagePoints1.push_back(defect_point);

			objectPoints1.push_back(Point3d(9,6,0));
			imagePoints1.push_back(defect_point);

		

			objectPoints1.push_back(Point3d(19,6,0));
			imagePoints1.push_back(fn);

			 objectPoints1.push_back(Point3d(9,18,0));
			   imagePoints1.push_back(ln);

			
			  // cout<<width<<"  &"<<height<<endl;
		//	cout<<"solvepnp"<<endl; 
			solvePnP(Mat(objectPoints1),Mat(imagePoints1),intrinsic_Matrix,distortion_coeffs,rvec,tvec);



			cv::Mat rotation;
			cv::Rodrigues(rvec, rotation);
			double offsetA[3][1] = {9,6,6};
			Mat offset(3, 1, CV_64FC1, offsetA);
			tvec = tvec + rotation*offset;


			generateProjectionModelview(intrinsic_Matrix, rotation, tvec, Projection, modelview);
			glMatrixMode(GL_PROJECTION);	
			GLfloat* projection = convertMatrixType(Projection);
			glLoadMatrixf(projection);
			delete[] projection;

			glMatrixMode(GL_MODELVIEW);
			GLfloat* modelView = convertMatrixType(modelview);
			glLoadMatrixf(modelView);
			delete[] modelView;
			
			//glTranslatef(0.0f,0.0f,-5.0f);
			glPushMatrix();
			glColor3f(1.0,0.0,0.0);
			
			glutWireTeapot(10.0/curr);
			glPopMatrix();
			glColor3f(1.0,1.0,1.0);

		}
		//Rotation Module
		if(defect_circle.size()==4)
		{

			five_fn=true;
			minEnclosingCircle(defect_circle,center,radius);
			//circle(img, center, (int)radius,Scalar(255,255,255), 2, 8, 0 );
			circle(img1, center,2,Scalar(0), 2, 8, 0 );

			vector<pair<float,Point>> pos;
			for(int in=0;in<FingerTips.size();in++)
			{
				Point p=FingerTips.back();
				FingerTips.pop_back();

				//if(in==0)
				//{
				pos.push_back(make_pair(distanceP2P(center,p),p));
				//position.push_back(pos);
			}
				//	}
				//else
				//	{
				//		cout<<"size is"<<position.size()<<endl;
				//	position[n].push_back(make_pair(distanceP2P(center,p),p));
				//}
			
			sort(pos.begin(),pos.end(),pairCompare);
			//	vector<pair<float,Point>> now=position[i].back();
			first=pos.back().second;
			pos.pop_back();
			//cout<<"new value :"<<new1.x<<" && "<<new1.y<<endl;
			second=pos.back().second;
			pos.pop_back();
			third=pos.back().second;
			pos.pop_back();
			
			if(third.y<second.y&&second.y<first.y)
			{
			//	cout<<"vertical pose"<<endl;
				FIX_X.x=center.x+40;
				FIX_X.y=center.y;

				FIX_Y.x=center.x;
				FIX_Y.y=center.y-40;
			}
			skew_x=getAngle(first,center,FIX_X);
			skew_y=getAngle(third,center,FIX_Y);
			cout<<skew_x<<"&"<<skew_y<<endl;
			if(first.x<img1.cols)
			line(img1,center,first,Scalar(200,200,200),2,8,0);
			line(img1,center,FIX_X,Scalar(200,200,200),2,8,0);
			if(second.x<img1.cols)
				line(img1,center,second,Scalar(0,255,0),2,8,0);
				if(third.x<img1.cols)
					line(img1,center,third,Scalar(0,0,255),2,8,0);
				line(img1,center,FIX_Y,Scalar(0,0,255),2,8,0);
		
			//	line(img1,center,first,Scalar(255,255,255),2,8,0);
			//	line(img1,center,second,Scalar(0,255,255),2,8,0);
			//	line(img1,center,third,Scalar(0,0,255),2,8,0);
		
		renderBackgroundGL(img1);

			/*	cvtColor(test, gray1, CV_RGB2GRAY);
			bool sCorner1=findChessboardCorners(gray1, Size(7, 7), corners1);
			imshow("live",test);
			if(sCorner1)
			{
			cornerSubPix(gray1, corners1, Size(11,11), Size(-1,-1), TermCriteria(CV_TERMCRIT_EPS+CV_TERMCRIT_ITER, 30, 0.1));
			if(corners1.size() == 7*7)
			{control pan

			for(int j=0; j< corners1.size(); ++j)
			{
			Point2f tImgPT;
			Point3f tObjPT;

			tImgPT.x = corners1[j].x;
			tImgPT.y = corners1[j].y;

			tObjPT.x = j%7*3;
			tObjPT.y = j/7*3;
			tObjPT.z = 0;
			imagePoints1.push_back(tImgPT);
			objectPoints1.push_back(tObjPT);     
			}

			vector<Point2f> projectedPoints;
			vector<Point3f> axis;

			axis.push_back(Point3f(6,0,0));
			axis.push_back(Point3f(0,6,0));
			axis.push_back(Point3f(0,0,6));  */
			objectPoints1.push_back(Point3d(9,6,0));
			imagePoints1.push_back(center);

			objectPoints1.push_back(Point3d(9,18,0));
			imagePoints1.push_back(first);

			objectPoints1.push_back(Point3d(19,6,0));
			imagePoints1.push_back(third);

			 objectPoints1.push_back(Point3d(15,15,0));
			   imagePoints1.push_back(second);

			
			  // cout<<width<<"  &"<<height<<endl;
		//	cout<<"solvepnp"<<endl; 
			solvePnP(Mat(objectPoints1),Mat(imagePoints1),intrinsic_Matrix,distortion_coeffs,rvec,tvec);



			cv::Mat rotation;
			cv::Rodrigues(rvec, rotation);
			double offsetA[3][1] = {9,6,0};
			Mat offset(3, 1, CV_64FC1, offsetA);
			tvec = tvec + rotation*offset;


			generateProjectionModelview(intrinsic_Matrix, rotation, tvec, Projection, modelview);

			/*  double offsetA[3][1] = {{(7-1.0)/2.0}, {(7-1.0)/2.0}, {0}};
			Mat offset(3, 1, CV_64FC1, offsetA);
			tvec = tvec + rotation*offset;

			for(unsigned int row=0; row<3; ++row)
			{
			for(unsigned int col=0; col<3; ++col)
			{
			modelview.at<float>(row, col) = rotation.at<float>(row, col);
			cout<<modelview.at<float>(row,col)<<endl;
			}
			modelview.at<float>(row, 3) = tvec.at<float>(row, 0);
			}
			modelview.at<float>(3, 3) = 1.0f;
			cout<<endl;



			static float changeCoordArray[4][4] = {{-1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 1}};
			static Mat changeCoord(4, 4, CV_64FC1, changeCoordArray);

			modelview = changeCoord*modelview;

			cv::Mat glmodelview = cv::Mat::zeros(4, 4, CV_64F);
			transpose(modelview , glmodelview);  
			gluLookAt(0.0,2.0,-50.0,0.0,0.5,0.0,0.0,1.0,0.0);
			/*	glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			float fx=intrinsic_Matrix.at<float>(0,0);
			float fy=intrinsic_Matrix.at<float>(1,1);
			float cf=(2*atanf(0.5*height/fy)*180/3.14);
			float aspect=(width*fy)/(height*fx);   

			//gluPerspective(cf,1.0, zNear, zFar);   



			glMatrixMode(GL_MODELVIEW);
			glLoadIdentity();

			glLoadMatrixf(&glmodelview.at<float>(0,0));  */
			glMatrixMode(GL_PROJECTION);	
			GLfloat* projection = convertMatrixType(Projection);
			glLoadMatrixf(projection);
			delete[] projection;

			glMatrixMode(GL_MODELVIEW);
			GLfloat* modelView = convertMatrixType(modelview);
			glLoadMatrixf(modelView);
			delete[] modelView;
			
			//glTranslat ef(0.0f,0.0f,-5.0f);
			glPushMatrix();
			glColor3f(1.0,0.0,0.0);
			glRotatef(skew_x,1.0,0.0,0.0);
			glRotatef(skew_y,0.0,1.0,0.0);
			glutWireTeapot(10.0);
			glPopMatrix();
			glColor3f(1.0,1.0,1.0);
			clock_t clock_5 = clock();
	cout<<"interaction time is :"<<(double)(clock_5-clock_4)<<endl;
		}
		imshow("live",img1);
		cout<<"----------------------------------------------"<<endl;

		glFlush();
		glutSwapBuffers();
	}
	waitKey(27);
	glutPostRedisplay();
}
void reshape(int x,int y)
{
	width=x; height=y;
	glViewport(0,0,width,height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	/*Projection.at<float>(0,0) = 2*intrinsic_Matrix.at<float>(0,0)/width;
	Projection.at<float>(1,0) = 0;
	Projection.at<float>(2,0) = 0;
	Projection.at<float>(3,0) = 0;

	Projection.at<float>(0,1) = 0;
	Projection.at<float>(1,1) = 2*intrinsic_Matrix.at<float>(1,1)/height;
	Projection.at<float>(2,1) = 0;
	Projection.at<float>(3,1) = 0;

	Projection.at<float>(0,2) = 1-2*intrinsic_Matrix.at<float>(0,2)/width;
	Projection.at<float>(1,2) = -1+(2*intrinsic_Matrix.at<float>(1,2)+2)/height;
	Projection.at<float>(2,2) = (zNear+zFar)/(zNear - zFar);
	Projection.at<float>(3,2) = -1;

	Projection.at<float>(0,3) = 0;
	Projection.at<float>(1,3) = 0;
	Projection.at<float>(2,3) = 2*zNear*zFar/(zNear - zFar);
	Projection.at<float>(3,3) = 0; 

	cv::Mat projection = cv::Mat::zeros(4, 4, CV_64F);
	transpose(Projection ,projection);  
	glLoadMatrixf(&projection.at<float>(0,0));   */


	// gluPerspective(60, (GLfloat)width / (GLfloat)height, 1.0, 100.0); 

	/* float fx=intrinsic_Matrix.at<float>(0,0);
	float fy=intrinsic_Matrix.at<float>(1,1);
	float cf=(2*atanf(0.5*height/fy)*180/3.14);
	cout<<fx<<"   "<<fy<<endl;
	float aspect=(width*fy)/(height*fx);  */
	//gluPerspective(cf,CALIB_FIX_ASPECT_RATIO, zNear, zFar); 


	//glMatrixMode(GL_MODELVIEW);
	//	gluPerspective(60,width/height, zNear, zFar);  
	//glOrtho(-100,100,-100.0,100,zNear, zFar);

}
void init()
{
	glClearColor(0.0f,0.0f,0.0f,0.0f);
}
void main()
{
	if(!cap.isOpened())
	{
		exit(-1);
	}
	cap >> test;
	if(!test.data)
	{
		exit(-1);
	}
//	resize(test,test,Size(180,180),0,0);
	width=test.cols;
	height=test.rows;
	cout<<width<<endl;
	calibrate(intrinsic_Matrix,distortion_coeffs);
	glutInitDisplayMode(GLUT_RGB |GLUT_DOUBLE |GLUT_DEPTH );
	glutInitWindowSize(width,height);
	glutCreateWindow("code4change");
	init();
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutMainLoop();
}
```
</details>

- [Augmented Reality on libQGLViewer and OpenCV-OpenGL tips [w/code]](http://www.morethantechnical.com/2015/02/17/augmented-reality-on-libqglviewer-and-opencv-opengl-tips-wcode/) ([SimpleARQGLViewer.cpp](https://gist.github.com/royshil/9feb86849c756ba608ae#file-simplearqglviewer-cpp)):
<details>

```
/*
 *  SimpleARQGLViewer.cpp
 *  Creating an AR application with QGLViewer
 *
 *  Created by Roy Shilkrot on 2/16/2015
 *  Copyright 2015 Roy Shilkrot. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 */

#include <opencv2/opencv.hpp>

#include <iostream>
#include <algorithm>

#include "OGL_OCV_common.h"
#include <GLUT/glut.h>

#include <qapplication.h>
#include <QBasicTimer>
#include <QGLViewer/qglviewer.h>

using namespace cv;
using namespace std;

class Tracker {
private:
    //...
    Mat raux,taux; //keep R and t for next frame
    //...
public:
    //...

    void process(const Mat& frame) {
        // track 2D features and match them to known 3D points
    }

    //...

    void calcModelViewMatrix(Mat& modelview_matrix, const Mat& camMat) {
        vector<Point2f> ObjPoints,ImagePoints;
        // Setup ObjPoints and ImagePoints so they correspond 3D -> 2D

        cv::Mat Rvec,Tvec;
        cv::solvePnP(ObjPoints, ImagePoints, camMat, Mat(), raux, taux, !raux.empty());
        raux.convertTo(Rvec,CV_32F);
        taux.convertTo(Tvec ,CV_64F);

        Mat Rot(3,3,CV_32FC1);
        Rodrigues(Rvec, Rot);

        // [R | t] matrix
        Mat_<double> para = Mat_<double>::eye(4,4);
        Rot.convertTo(para(Rect(0,0,3,3)),CV_64F);
        Tvec.copyTo(para(Rect(3,0,1,3)));

        Mat cvToGl = Mat::zeros(4, 4, CV_64F);
        cvToGl.at<double>(0, 0) = 1.0f;
        cvToGl.at<double>(1, 1) = -1.0f; // Invert the y axis
        cvToGl.at<double>(2, 2) = -1.0f; // invert the z axis
        cvToGl.at<double>(3, 3) = 1.0f;

        para = cvToGl * para;

        Mat(para.t()).copyTo(modelview_matrix); // transpose to col-major for OpenGL
    }
};

class OpenCVCamera : public qglviewer::Camera {
public:
    Mat camMat;

    virtual void loadProjectionMatrix(bool reset) const {
        static Mat_<double> persp;
        double near = 1, far = 100.0;

        glMatrixMode(GL_PROJECTION);
        if(persp.empty()) {
            persp.create(4,4); persp.setTo(0);

            // http://kgeorge.github.io/2014/03/08/calculating-opengl-perspective-matrix-from-opencv-intrinsic-matrix/
            double fx = camMat.at<float>(0,0);
            double fy = camMat.at<float>(1,1);
            double cx = camMat.at<float>(0,2);
            double cy = camMat.at<float>(1,2);
            persp(0,0) = fx/cx;
            persp(1,1) = fy/cy;
            persp(2,2) = -(far+near)/(far-near);
            persp(2,3) = -2.0*far*near / (far-near);
            persp(3,2) = -1.0;

            cout << "perspective m \n" << persp << endl;

            persp = persp.t(); //to col-major
        }
        glLoadMatrixd((double*)persp.data);
    }
};

class Viewer : public QGLViewer
{
protected :
    VideoCapture            vc;
    Mat                     frame;
    Mat                     orig_gray;
    RS::OpenCVGLTexture     ocv_tex;
    Tracker                 tracker;
    Mat_<float>             camMat;
    Mat_<double>            modelViewMatrix;
    QBasicTimer*            frameTimer;

public:
    Viewer() {

        vc.open("myvideo.MOV");
        if(!vc.isOpened()) {
            cerr << "can't open video\n";
        } else {
            Mat frame_,orig,orig_warped,tmp;
            vc >> frame_;
            if(frame_.empty()) {
                cerr << "can't get first frame\n";
            } else {
                frame_.copyTo(frame);
                float f = std::max(frame.cols,frame.rows);
                camMat = (Mat_<float>(3,3) <<   f,       0,       frame.cols/2,
                                                0,       f,       frame.rows/2,
                                                0,       0,       1);

                frameTimer = new QBasicTimer();
            }
        }
    }
    ~Viewer() {
        frameTimer->stop();
        delete frameTimer;
    }

    virtual void draw() {
      drawBackground();

      glLoadMatrixd((double*)modelViewMatrix.data);

      glPushMatrix();
      glDisable(GL_LIGHTING);
      glColor3f(1,0,0);
      glTranslatef(0,0,-0.3);
      glutWireCube( 0.6 );
      glEnable(GL_LIGHTING);
      glPopMatrix();
  }

  virtual void init() {
      // Enable GL textures
      glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
      glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
      // Nice texture coordinate interpolation
      glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

      ocv_tex = RS::MakeOpenCVGLTexture(frame);

      setFixedHeight(frame.rows);
      setFixedWidth(frame.cols);

      clearMouseBindings();

      frameTimer->start(1,this);
      detectorTimer->start(1,this);

      OpenCVCamera* c = new OpenCVCamera;
      c->camMat = camMat;
      setCamera(c);
  }

  void timerEvent(QTimerEvent *timer) {
      Mat frame_;
      vc >> frame_;
      if(frame_.empty()) return;

      frame_.copyTo(frame);

      tracker.process(frame);
      tracker.calcModelViewMatrix(modelViewMatrix,camMat);

      ocv_tex.set(frame);

      updateGL();
  }

  void drawBackground()
  {

    glDisable(GL_LIGHTING);
    glEnable(GL_TEXTURE_2D);
    glColor3f(1,1,1);

    startScreenCoordinatesSystem(true);

    // Draws the background quad
    RS::drawOpenCVImageInGLOnlyQuad(ocv_tex,width(),height());

    stopScreenCoordinatesSystem();

    // Depth clear is not absolutely needed. An other option would have been to draw the
    // QUAD with a 0.999 z value (z ranges in [0, 1[ with startScreenCoordinatesSystem()).
    glClear(GL_DEPTH_BUFFER_BIT);
    glDisable(GL_TEXTURE_2D);
    glEnable(GL_LIGHTING);
  }

};

int main(int argc, char** argv) {

    // Read command lines arguments.
    QApplication application(argc,argv);

    cout << "running...\n";

    // Instantiate the viewer.
    Viewer viewer;

    viewer.setWindowTitle("Simple AR QGLViewer");

    // Make the viewer window visible on screen.
    viewer.show();

    // Run main loop.
    return application.exec();

}
```
</details>

- [How to properly texture a quad in opengl](https://stackoverflow.com/questions/27513201/how-to-properly-texture-a-quad-in-opengl/27518790#27518790):
<details>

```
#include <GL/glut.h>

GLuint glInitTexture(char* filename)
{
    GLuint t = 0;

    glGenTextures( 1, &t );
    glBindTexture(GL_TEXTURE_2D, t);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    unsigned char data[] = { 255, 0, 0, 255 };
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 1, 1, 0, GL_RGBA, GL_UNSIGNED_BYTE, data );
    return t;
}

void drawImage(GLuint file,
    float x,
    float y,
    float w,
    float h,
    float angle)
{
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
    glPushMatrix();
    glTranslatef(x, y, 0.0);
    glRotatef(angle, 0.0, 0.0, 1.0);

    glBindTexture(GL_TEXTURE_2D, file);
    glEnable(GL_TEXTURE_2D);

    glBegin(GL_QUADS);
    glTexCoord2f(0.0, 0.0); glVertex3f(x, y, 0.0f);
    glTexCoord2f(0.0, 2.0); glVertex3f(x, y + h, 0.0f);
    glTexCoord2f(2.0, 2.0); glVertex3f(x + w, y + h, 0.0f);
    glTexCoord2f(2.0, 0.0); glVertex3f(x + w, y, 0.0f);
    glEnd();

    glPopMatrix();
}

GLuint texture;
void render()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glEnable(GL_DEPTH_TEST);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    const double w = glutGet( GLUT_WINDOW_WIDTH );
    const double h = glutGet( GLUT_WINDOW_HEIGHT );
    gluPerspective(45.0, w / h, 0.1, 1000.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef( 0, 0, -15 );

    drawImage(texture, 0.0f, 0.0f, 4.0f, 4.0f, 0.0);

    glutSwapBuffers();
}

int main(int argc, char* argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(600, 600);
    glutCreateWindow("Applying Textures");
    glutDisplayFunc(render);

    texture = glInitTexture("image.png");

    glutMainLoop();
    return 0;
}
```
</details>

- [Marker-less Augmented Reality by OpenCV and OpenGL](https://medium.com/@ahmetozlu93/marker-less-augmented-reality-by-opencv-and-opengl-531b2af0a130)
- [Marker-less Augmented Reality](https://github.com/ahmetozlu/augmented_reality)

### Books
- [OpenGL Programming Guide](https://www.glprogramming.com/red/)
- [The OpenGL® Programming Guide, 9th Edition](http://www.opengl-redbook.com/)
- [The OpenGL® Programming Guide, 8th Edition](https://www.cs.utexas.edu/users/fussell/courses/cs354/handouts/Addison.Wesley.OpenGL.Programming.Guide.8th.Edition.Mar.2013.ISBN.0321773039.pdf)
- [OpenGL SuperBible, Fourth Edition](http://newton.uam.mx/xgeorge/uea/graficacion/(Addison%20Wesley)%20OpenGL%20SuperBible%20(2007).pdf)
- [Advanced Graphics Programming Using OpenGL](http://newton.uam.mx/xgeorge/uea/graficacion/(Morgan%20Kaufmann)%20Advanced%20Graphics%20Programming%20Using%20OpenGL%20(2005).pdf)
