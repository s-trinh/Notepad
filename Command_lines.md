## FFmpeg
- [convert a sequence of images to a video](https://trac.ffmpeg.org/wiki/Slideshow):
`ffmpet -framerate 30 -i color_image_%04d.jpg -c:v libx264 -preset slow -crf 24 -an -pix_fmt yuv420p out.mp4`
- [side by side videos](https://stackoverflow.com/questions/42255139/ffmpeg-merge-two-videos-into-one-with-side-by-side-same-quality-output):
ffmpeg -i left.avi -i right.avi -filter_complex hstack -c:v ffv1 output.avi
- [video to gif](https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality/556031#556031): `ffmpeg -i input.mp4 -vf palettegen palette.png` `ffmpeg -i input.mp4 -i palette.png -filter_complex "paletteuse" output.gif`

## Bash
- [add leading zeros to filenames](https://unix.stackexchange.com/questions/346917/rename-files-to-add-leading-zeros-to-numbers/346923#346923):
`rename -e 's/\d+/sprintf("%04d",$&)/e' -- *.jpg`
- [convert png images to jpg](https://superuser.com/questions/71028/batch-converting-png-to-jpg-in-linux/542671#542671):
`for i in *.png ; do convert "$i" "/home/user/dir/${i%.*}.jpg" ; done`
- [replace filename using pattern](https://stackoverflow.com/questions/6840332/rename-multiple-files-by-replacing-a-particular-pattern-in-the-filenames-using-a/6840404#6840404):
`for f in *.jpg; do mv "$f" "$(echo "$f" | sed s/old_name_/new_name_/)"; done`

## Git
- [Git commit message with text editor](https://stackoverflow.com/questions/5064563/add-line-break-to-git-commit-m-from-the-command-line/27358418#27358418): `git commit -e`
