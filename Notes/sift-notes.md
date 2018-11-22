A few sketchy notes about SIFT
------------------------------

See the papers for more details:
  http://www.cs.ubc.ca/~lowe/keypoints/
  http://www.cs.toronto.edu/~kyros/courses/320/Lectures/lowe-sift-ijcv04.pdf

We assume that keypoints have already been detected, as "corners" in 
scale-space, namely local minima/maxima in 3x3x3 regions of the DOG 
(Difference-of-Gaussian) pyramids.

How the SIFT feature descriptors are computed:

[1] each keypoint is assigned an orientation, corresponding to the *dominant* 
    orientation within that patch -- specifying this gives rotation invariance, 
    as all other descriptors are computed relative to this orientation

   - find the gradient magnitude and orientation in a neighborhood (all of this 
     is at the relevant scale)
   - bin the orientation, \theta = tan(G_y/G_x), into one of 36 bins, each 
     covering 10 degrees 
   - each pixel in the neighborhood contributes to the bin corresponding 
     to its orientation:
      - proportional to the its gradient magnitude, \sqrt(G_x^2+G_y^2)
      - and with a circular Gaussian falloff from the keypoint center 
        (\sigma=1.5 pixels at the current scale, so the effective 
        neighborhood is about 9x9)
   - the highest peak of the histogram is the *dominant* orientation
   - (if there are multiple peaks within 0.8 of the max, add each of those as 
      separate SIFT features)
   - (interpolate the peak using a parabola fit to the +-1 neighboring bins, 
      for better accuracy)

[2] given a keypoint and a dominant orientation, we build the descriptor
    as follows

   - consider a 16x16 patch centered on the keypoint (at the relevant scale)
   - decompose this patch into 4x4 pixel tiles .. so there will be 
     (16/4)*(16/4)=16 such tiles
   - for each such tile, we compute a histogram of its pixels' gradient 
     orientations with 8 bins, each covering 45 degrees
      - actually, we specify these gradient orientations *relative* to the 
        keypoint's dominant orientation, ie. \theta' = tan(G_y/G_x)-\theta
      - again weight the contribution to the bin by the gradient magnitude
      - again we use a circular Gaussian falloff from the keypoint center 
        (\sigma=8 pixels, half the descriptor window)
   - so this gives 16 tiles * 8 histogram bins/tile = a 128-dimensional vector 
     representing our a SIFT feature descriptor
   - normalize this to unit length, for better illumination invariance
   - (also, threshold values in this normalized vector to be no larger than 0.2, 
      and then renormalize)

How to match SIFT features:

[1] Define a distance measure between two SIFT feature vectors
   - this is easy ... just find the Euclidian distance in the space of 
     128-dimensional vectors, d = [\sum_{i=1}^{128} (p_i - q_i)^2]^{1/2}
   - in practice use kd-trees or other specialized structures for efficient 
     (maybe even approximate) nearest-neighbor queries in a large database of 
     SIFT features (perhaps ~100k in a big scene)
   - (can also do dimensionality reduction using e.g. Haar wavelets; in fact 
      this transform would preserve the Euclidean distance, since the Haar 
      wavelet basis is *orthogonal*)

[2] For applications like recognition, panorama stitching, etc. we need 
    to know: does the best SIFT feature match in the database constitute a 
    *real* match, or is it just a false positive?

   - setting a hard distance threshold in 128-dimensional space 
     (ie. below this threshold = a match) doesn't work well
   - better: compare the distance to best matching SIFT feature in the database, 
     and the distance to the *2nd-best* matching feature -- if the ratio of 
     closest distance to 2nd closest distance >0.8 then reject as a false match!
