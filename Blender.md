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
- [select the desired camera](https://blender.stackexchange.com/a/3503/26684) (third icon > `Scene`) and render the animation

### Add noise to a trajectory
- [Simulate POV Walking Camera](https://blender.stackexchange.com/questions/92600/simulate-pov-walking-camera/92604#92604)
- open a new panel and choose `Graph Editor` instead of `3D View`
- make right tab panel visible
- in `Modifiers`, select `Noise` and change the strength parameter
- multiple `Modifiers` can be added, frame range can also be restricted
