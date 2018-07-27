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
- [fetch branch from another repository](https://stackoverflow.com/questions/14383212/git-pulling-a-branch-from-another-repository/14383288#14383288):
```
git remote add remote_name <url of remote>
git fetch remote_name
git checkout -b remote_name_for_example/local_branch_name remote_name/remote_branch_name
```
- [Git push a local branch to another repository](https://stackoverflow.com/questions/35939308/pushing-code-from-one-branch-of-a-repo-to-another-branch-of-another-repo/35944743#35944743): `git push -u <remote name, e.g. origin> <local branch name>:<remote branch name>`
- [Stash only one file out of multiple files that have changed with Git?](https://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git#17969785): `git stash save -p "my commit message"`
