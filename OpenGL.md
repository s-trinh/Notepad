### Tutorials
- [Learn OpenGL](https://learnopengl.com/)
- [Learn Computer Graphics From Scratch!](https://www.scratchapixel.com/)
- [OGL dev - Modern OpenGL Tutorials](http://ogldev.atspace.co.uk/)
- [opengl-tutorial](http://www.opengl-tutorial.org/)
- [https://open.gl/](https://open.gl/)
- [An intro to modern OpenGL. Table of Contents](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Table-of-Contents.html)

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

### Documentation
- [Coordinate Systems](https://learnopengl.com/Getting-started/Coordinate-Systems)
- [An intro to modern OpenGL. Chapter 2.1: Buffers and Textures](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Chapter-2.1:-Buffers-and-Textures.html)

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

- [Chapter 4. Camera Models and Augmented Reality](https://www.oreilly.com/library/view/programming-computer-vision/9781449341916/ch04.html):

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

### Books
- [OpenGL Programming Guide](https://www.glprogramming.com/red/)
- [The OpenGL® Programming Guide, 9th Edition](http://www.opengl-redbook.com/)
- [The OpenGL® Programming Guide, 8th Edition](https://www.cs.utexas.edu/users/fussell/courses/cs354/handouts/Addison.Wesley.OpenGL.Programming.Guide.8th.Edition.Mar.2013.ISBN.0321773039.pdf)
- [OpenGL SuperBible, Fourth Edition](http://newton.uam.mx/xgeorge/uea/graficacion/(Addison%20Wesley)%20OpenGL%20SuperBible%20(2007).pdf)
- [Advanced Graphics Programming Using OpenGL](http://newton.uam.mx/xgeorge/uea/graficacion/(Morgan%20Kaufmann)%20Advanced%20Graphics%20Programming%20Using%20OpenGL%20(2005).pdf)
