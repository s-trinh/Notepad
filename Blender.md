### Shortcuts
- insert keyframe: `press i`
- delete keyframe: `alt + i`
- [group objects](https://blender.stackexchange.com/questions/33743/group-objects-in-blender/33748#33748): `select > ctrl + p > keep transform`

### Generate color and depth map
- references:
  - [Z-buffer output from blender as file](https://blender.stackexchange.com/questions/33293/z-buffer-output-from-blender-as-file)
  - [Render depth maps with world-space z distance with respect the camera](https://blender.stackexchange.com/questions/52328/render-depth-maps-with-world-space-z-distance-with-respect-the-camera/52348#52348)
- when adding a new camera, the new one may have a bigger size. Set the appropriate size (should be `0.5`) in `Camera > Display > Size`
- [group](https://blender.stackexchange.com/questions/33743/group-objects-in-blender/33748#33748) the two cameras: `select > ctrl + p > keep transform`
- go to Compositing view
- tick `Use Nodes`, tick `Backdrop` and `Auto render`?
- add `File Output` node, use `OpenEXR` file format
- [select the desired camera](https://blender.stackexchange.com/questions/3502/how-can-i-make-a-camera-the-active-one/3503#3503) (third icon > `Scene`) and render the animation

### Add noise to a trajectory
- [Simulate POV Walking Camera](https://blender.stackexchange.com/questions/92600/simulate-pov-walking-camera/92604#92604)
- open a new panel and choose `Graph Editor` instead of `3D View`
- make right tab panel visible
- in `Modifiers`, select `Noise` and change the strength parameter
- multiple `Modifiers` can be added, frame range can also be restricted

### Add multiple image textures for a cube
- [How do I put an image texture on a material in Cycles?](https://blender.stackexchange.com/questions/8697/how-do-i-put-an-image-texture-on-a-material-in-cycles)
- [Unwrapping a cube for multiple textures?](https://blender.stackexchange.com/questions/73426/unwrapping-a-cube-for-multiple-textures)
- Example:
  - Use default cube
  - There should be one `Material`, remove the default texture?
  - Add texture: `New` button > `Open` button
  - Split screens: `UV/Image Editor`, switch `3D View` to `Texture` (`Viewport Shading`)
  - Edit mode (`tab`), select one face
  - Press `u` key > `Unwrap`
  - `UV/Image Editor`, `Browse Image to be linked`
  - For another texture
  - Add a new `Material` (`+` button) > `New` button
  - `Texture` tab, `New` button > `Open` button
  - Select another face
  - Press `u` key > `Unwrap` > `Browse Image to be linked`
  - `Material` tab > `Assign`
 
### Add a texture for a teabox
- See previous example
- To select all vertices in edit mode: press `a` key
- No need to unwrap?
 
### Export multiple objects (meshes) to PLY:
- [How can I make multiple meshes into a single hollow mesh?](https://blender.stackexchange.com/questions/39961/how-can-i-make-multiple-meshes-into-a-single-hollow-mesh/39963#39963):
> For separate meshes, you should first of all join them in a single object (`Ctrl + J`)
 
### Make top bar menu come back
- [Menu disappeared](https://blender.stackexchange.com/questions/92489/menu-disappeared/92490#92490)
- > Create a new "window" (by dragging the top-right corner of any frame down or left)
- > On the window view selector (on the bottom-left corner of the "window"), select "info" from the dropdown.
- > You can then select a new Layout and work from there

### Save depth from Python
- [How to get Color and Z-Depth from Viewer Node?](https://blender.stackexchange.com/questions/35191/how-to-get-color-and-z-depth-from-viewer-node/71264#71264)
- [How to save an .exr file with 32 bit with python](https://blender.stackexchange.com/questions/95380/how-to-save-an-exr-file-with-32-bit-with-python/95384#95384)
- [Clip depth field of view in nodes](https://blender.stackexchange.com/questions/128456/clip-depth-field-of-view-in-nodes):
```
import bpy
import numpy as np

# https://blender.stackexchange.com/questions/35191/how-to-get-color-and-z-depth-from-viewer-node/71264#71264
bpy.context.scene.render.use_compositing = True
bpy.context.scene.use_nodes = True
tree = bpy.context.scene.node_tree
links = tree.links

for n in tree.nodes:
    tree.nodes.remove(n)
rl = tree.nodes.new('CompositorNodeRLayers')

vl = tree.nodes.new('CompositorNodeViewer')
vl.use_alpha = True
links.new(rl.outputs[0], vl.inputs[0])  # link Render Image to Viewer Image
links.new(rl.outputs[2], vl.inputs[1])  # link Render Z to Viewer Alpha

#render
bpy.context.scene.render.resolution_percentage = 100 #make sure scene height and width are ok (edit)

step_count = 251
scene = bpy.context.scene
for step in range(1, step_count):
    # Set render frame
    scene.frame_set(step)

    # Render
    bpy.ops.render.render()

    #get the pixels and put them into a numpy array
    pixels = np.array(bpy.data.images['Viewer Node'].pixels)

    width = bpy.context.scene.render.resolution_x 
    height = bpy.context.scene.render.resolution_y

    #reshaping into image array 4 channel (rgbz)
    image = pixels.reshape(height,width,4)

    #get only depth
    z = image[:,:,3]

    #simulate depth sensor fov / depth range
    def clip_depth(z, z_near, z_far, default_value=0):
        if z > z_far:
            return default_value
        elif z < z_near:
            return default_value
        else:
            return z

    clip_func = np.vectorize(clip_depth, otypes=[np.float])
    z_near = 1
    z_far = 8
    z_clip = clip_func(z, z_near, z_far)

    #save depth to OpenEXR format
    image_settings = bpy.context.scene.render.image_settings
    image_settings.file_format = "OPEN_EXR"
    image_settings.color_depth = '32'

    #create an HDR image with name 'img_z'
    image_name = 'img_z'
    bpy.ops.image.new(name=image_name, width=z_clip.shape[1], height=z_clip.shape[0], alpha=True, float=True)
    img_z_clip = bpy.data.images[image_name]

    z_clip_rgba = np.dstack((z_clip, z_clip, z_clip, z_clip))
    img_z_clip.pixels = z_clip_rgba.ravel()
    img_z_clip.save_render('/tmp/blender_z_depth_clip_%04d.exr' % step)
```
- [Is it possible to edit images programmatically with the Blender API? ](https://blender.stackexchange.com/questions/15890/is-it-possible-to-edit-images-programmatically-with-the-blender-api/15894#15894)
- [Crop image with Python script](https://blender.stackexchange.com/questions/13422/crop-image-with-python-script/13516#13516)
- [Why is accessing image data so slow?](https://blender.stackexchange.com/questions/3673/why-is-accessing-image-data-so-slow/3678#3678):
```
img = bpy.data.images['Untitled']

pixels = img.pixels[:] # create a copy (tuple) for read-only access
# -- OR --
pixels = list(img.pixels) # create an editable copy (list)

# Use the tuple object, which is way faster than direct access to Image.pixels
for i in range(0, len(pixels), 4):
    pixels[i] = 1.0 - pixels[i] # invert red channel

# Write back to image.
# Slice notation here means to replace in-place, not sure if it's faster...
img.pixels[:] = pixels

# Should probably update image
img.update()
```
- [How to convert numpy array into image and add it to images inside bpy](https://blender.stackexchange.com/questions/92692/how-to-convert-numpy-array-into-image-and-add-it-to-images-inside-bpy/105312#105312):
```
numpy.zeroes((100,100,4), dtype = float16)

if "TestImg.png" not in bpy.data.images.keys():
    bpy.data.images.new("TestImg.png", width=128, height=128, alpha=True, float_buffer=False)
outputImg = bpy.data.images["TestImg.png"] 
input_res = int(math.sqrt(outputImg.size[0]))
np_out_img = np.zeros((input_res,input_res,4), dtype = np.float16)
outputImg.pixels = np_out_img.ravel()  #flatten the array to 1 dimension and write it to testImg pixels
```
- [Adjusting image pixels internally in Blender with bpy](https://blenderscripting.blogspot.com/2012/08/adjusting-image-pixels-internally-in.html)
- [Blender Python Recipes](https://github.com/zeffii/BlenderPythonRecipes)

### Blender camera: principal point
- [What is blender's camera projection matrix model?](https://blender.stackexchange.com/questions/15102/what-is-blenders-camera-projection-matrix-model/38189#38189)
- [How to set a principal point for a camera](https://blender.stackexchange.com/questions/883/how-to-set-a-principal-point-for-a-camera/889#889)
- [Cycles Experiment: Pinhole Camera](https://bensimonds.com/2013/03/04/cycles-experiment-pinhole-camera/)
- [What are the units for camera shift?](https://blender.stackexchange.com/questions/58235/what-are-the-units-for-camera-shift/58236#58236)
- [From Blender to OpenCV Camera and back](https://www.rojtberg.net/1601/from-blender-to-opencv-camera-and-back/)
- [Orthographic view with something like shift/transformation?](https://blender.stackexchange.com/questions/98836/orthographic-view-with-something-like-shift-transformation/98871#98871)
