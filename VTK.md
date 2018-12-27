### Load OBJ model file with texture
- [https://www.vtk.org/gitweb?p=VTK.git;a=blob;f=Examples/IO/Cxx/objtovtp.cxx](https://www.vtk.org/gitweb?p=VTK.git;a=blob;f=Examples/IO/Cxx/objtovtp.cxx)
- [OBJImporter](https://lorensen.github.io/VTKExamples/site/Cxx/IO/OBJImporter/)
```
vtkNew<vtkOBJImporter> importer;

importer->SetFileName(filenameOBJ.data());
importer->SetFileNameMTL(filenameMTL.data()); //MTL can be opened to change the image path
std::string texturePath = vtksys::SystemTools::GetFilenamePath(objPath);
importer->SetTexturePath(texturePath.data()); //Image is defined in relative path

vtkNew<vtkRenderer> ren;
vtkNew<vtkRenderWindow> renWin;
vtkNew<vtkRenderWindowInteractor> iren;
 
renWin->AddRenderer(ren);
iren->SetRenderWindow(renWin);
importer->SetRenderWindow(renWin);
importer->Update();
```

### Set camera intrinsic parameters
- [OpenGL/VTK: setting camera intrinsic parameters](https://stackoverflow.com/questions/18019732/opengl-vtk-setting-camera-intrinsic-parameters/35489926#35489926)
- [make_vtk_camera.cpp](https://gist.github.com/decrispell/fc4b69f6bedf07a3425b)
- [How to interpret the VtkCamera viewTransformMatrix](https://stackoverflow.com/questions/18077105/how-to-interpret-the-vtkcamera-viewtransformmatrix/38801824#38801824)
- [Question on manual configuration of VTK camera](http://vtk.1045678.n5.nabble.com/Question-on-manual-configuration-of-VTK-camera-td5059478.html)

### User guide
- [The VTK-m User’s Guide](http://m.vtk.org/images/c/c8/VTKmUsersGuide.pdf)
- [The VTK User’s Guide - 11th Edition](https://www.kitware.com/products/books/VTKUsersGuide.pdf)

### Camera
- `vtkCamera` frame convention is [OpenGL convention](https://learnopengl.com/Getting-started/Camera):
![OpenGL camera](https://raw.githubusercontent.com/s-trinh/Notepad/master/Assets/VTK/camera_axes.png "OpenGL/VTK camera frame")
- Camera intrinsic parameters <--> view angle conversion: [Angle of view](https://en.wikipedia.org/wiki/Angle_of_view#Calculating_a_camera.27s_angle_of_view)
