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
- [make_vtk_camera.cpp](https://gist.github.com/decrispell/fc4b69f6bedf07a3425b)
- [How to interpret the VtkCamera viewTransformMatrix](https://stackoverflow.com/questions/18077105/how-to-interpret-the-vtkcamera-viewtransformmatrix/38801824#38801824)
- [Question on manual configuration of VTK camera](http://vtk.1045678.n5.nabble.com/Question-on-manual-configuration-of-VTK-camera-td5059478.html)
