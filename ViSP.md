## vpPose
Division by zero in `poseLagrangePlan`.
Estimated pose by Dementhon produces a pose that will transform the Z coordinate to zero in the camera frame.
Edge case but should not be an issue since the input points come from a RANSAC like method.
```
    std::vector<vpPoint> points;
    vpPoint pt;
    pt.setWorldCoordinates(0.045999999999999999, 0.069000000000000006, 0);
    pt.set_x(-0.32337786565071169);
    pt.set_y(-0.44624108472360602);
    points.push_back(pt);

    pt.setWorldCoordinates(-0.023, -0.023, 0);
    pt.set_x(0.041055128916913493);
    pt.set_y(-0.4833418120538191);
    points.push_back(pt);

    pt.setWorldCoordinates(-0.023, 0, 0);
    pt.set_x(0.01732902249975039);
    pt.set_y(0.40041653896587187);
    points.push_back(pt);

    pt.setWorldCoordinates(0.023, 0.045999999999999999, 0);
    pt.set_x(0.10796274901331343);
    pt.set_y(-0.032900930237001365);
    points.push_back(pt);
```
