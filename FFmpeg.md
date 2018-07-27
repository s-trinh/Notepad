## FFmpeg
- [convert a sequence of images to a video](https://trac.ffmpeg.org/wiki/Slideshow):
`ffmpet -framerate 30 -i color_image_%04d.jpg -c:v libx264 -preset slow -crf 24 -an -pix_fmt yuv420p out.mp4`
- [side by side videos](https://stackoverflow.com/questions/42255139/ffmpeg-merge-two-videos-into-one-with-side-by-side-same-quality-output):
ffmpeg -i left.avi -i right.avi -filter_complex hstack -c:v ffv1 output.avi
- [video to gif](https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality/556031#556031): `ffmpeg -i input.mp4 -vf palettegen palette.png` `ffmpeg -i input.mp4 -i palette.png -filter_complex "paletteuse" output.gif`
