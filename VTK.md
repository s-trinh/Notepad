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

### Z-Buffer
- [ZBuffer.cxx](https://vtk.org/Wiki/VTK/Examples/Cxx/Utilities/ZBuffer):
```
// This demo creates depth map for a polydata instance by extracting
// exact ZBuffer values.
#include <vtkSmartPointer.h>

#include <vtkPolyDataMapper.h>
#include <vtkActor.h>
#include <vtkRenderer.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkXMLPolyDataReader.h>
#include <vtkBMPWriter.h>
#include <vtkWindowToImageFilter.h>
#include <vtkImageShiftScale.h>

int main(int argc, char *argv[])
{
  if (argc < 3)
    {
      std::cout << "Usage: " << argv[0]
                << " input(.vtp) output(.bmp)"
                << std::endl;
      return EXIT_FAILURE;
    }

  vtkSmartPointer<vtkPolyDataMapper> mapper =
    vtkSmartPointer<vtkPolyDataMapper>::New();
  vtkSmartPointer<vtkActor> actor =
    vtkSmartPointer<vtkActor>::New();
  vtkSmartPointer<vtkRenderer> renderer =
    vtkSmartPointer<vtkRenderer>::New();
  vtkSmartPointer<vtkRenderWindow> renWin =
    vtkSmartPointer<vtkRenderWindow>::New();
  vtkSmartPointer<vtkRenderWindowInteractor> interactor =
    vtkSmartPointer<vtkRenderWindowInteractor>::New();
  vtkSmartPointer<vtkXMLPolyDataReader> fileReader =
    vtkSmartPointer<vtkXMLPolyDataReader>::New();
  vtkSmartPointer<vtkWindowToImageFilter> filter =
    vtkSmartPointer<vtkWindowToImageFilter>::New();
  vtkSmartPointer<vtkBMPWriter> imageWriter =
    vtkSmartPointer<vtkBMPWriter>::New();
  vtkSmartPointer<vtkImageShiftScale> scale =
    vtkSmartPointer<vtkImageShiftScale>::New();
        
  // Read .vtp file
  fileReader->SetFileName(argv[1]);

  //Build visualization enviroment
  mapper->SetInputConnection(fileReader->GetOutputPort());
  actor->SetMapper(mapper);
  renderer->AddActor(actor);
  renWin->AddRenderer(renderer);
  interactor->SetRenderWindow(renWin);
  renWin->Render();
  
  // Create Depth Map
  filter->SetInput(renWin);
  filter->SetMagnification(1);
  filter->SetInputBufferTypeToZBuffer();        //Extract z buffer value

  scale->SetOutputScalarTypeToUnsignedChar();
  scale->SetInputConnection(filter->GetOutputPort());
  scale->SetShift(0);
  scale->SetScale(-255);

  // Write depth map as a .bmp image
  imageWriter->SetFileName(argv[2]);
  imageWriter->SetInputConnection(scale->GetOutputPort());
  imageWriter->Write();

  return EXIT_SUCCESS;
}
```
- [Z-buffer to Depth: formula](http://vtk.1045678.n5.nabble.com/Z-buffer-to-Depth-formula-td5056542.html)
- [12 The Depth Buffer](https://www.opengl.org/archives/resources/faq/technical/depthbuffer.htm)
- [Build depth map of a 3D model](http://vtk.1045678.n5.nabble.com/Build-depth-map-of-a-3D-model-td5689116.html)
- [Get depth from camera for each pixel](https://stackoverflow.com/questions/17659362/get-depth-from-camera-for-each-pixel)

### VTK examples
- [VTK Examples](https://lorensen.github.io/VTKExamples/site/)
