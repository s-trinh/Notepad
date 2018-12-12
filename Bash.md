## Bash
- [add leading zeros to filenames](https://unix.stackexchange.com/questions/346917/rename-files-to-add-leading-zeros-to-numbers/346923#346923):
`rename -e 's/\d+/sprintf("%04d",$&)/e' -- *.jpg`
- [convert png images to jpg](https://superuser.com/questions/71028/batch-converting-png-to-jpg-in-linux/542671#542671):
`for i in *.png ; do convert "$i" "/home/user/dir/${i%.*}.jpg" ; done`
- [replace filename using pattern](https://stackoverflow.com/questions/6840332/rename-multiple-files-by-replacing-a-particular-pattern-in-the-filenames-using-a/6840404#6840404):
`for f in *.jpg; do mv "$f" "$(echo "$f" | sed s/old_name_/new_name_/)"; done`
- [List all installed packages in size order](https://ubuntuforums.org/showthread.php?t=599424): `dpkg-query -W --showformat='${Installed-Size;10}\t${Package}\n' | sort -k1,1n`
- [show file size](https://ubuntuforums.org/showthread.php?t=1513757): `ls -sh`
