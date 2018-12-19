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
