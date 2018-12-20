## Bash
- [add leading zeros to filenames](https://unix.stackexchange.com/questions/346917/rename-files-to-add-leading-zeros-to-numbers/346923#346923):
`rename -e 's/\d+/sprintf("%04d",$&)/e' -- *.jpg`
- [convert png images to jpg](https://superuser.com/questions/71028/batch-converting-png-to-jpg-in-linux/542671#542671):
`for i in *.png ; do convert "$i" "/home/user/dir/${i%.*}.jpg" ; done`
- [replace filename using pattern](https://stackoverflow.com/questions/6840332/rename-multiple-files-by-replacing-a-particular-pattern-in-the-filenames-using-a/6840404#6840404):
`for f in *.jpg; do mv "$f" "$(echo "$f" | sed s/old_name_/new_name_/)"; done`
- [List all installed packages in size order](https://ubuntuforums.org/showthread.php?t=599424): `dpkg-query -W --showformat='${Installed-Size;10}\t${Package}\n' | sort -k1,1n`
- [show file size](https://ubuntuforums.org/showthread.php?t=1513757): `ls -sh`
- [Download Google Drive files with WGET](https://gist.github.com/iamtekeste/3cdfd0366ebfd2c0d805#gistcomment-2151867):
```
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=FILEID' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=FILEID" -O FILENAME && rm -rf /tmp/cookies.txt 
```
- [How to assign the output of a Bash command to a variable?](https://stackoverflow.com/questions/2314750/how-to-assign-the-output-of-a-bash-command-to-a-variable/2314765#2314765):
```
pwd=$(pwd)
# or
pwd=`pwd`
```
- [What does set -e mean in a bash script?](https://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script/19622569#19622569):
> `set -e` stops the execution of a script if a command or pipeline has an error - which is the opposite of the default shell behaviour, which is to ignore errors in scripts. Type help set in a terminal to see the documentation for this built-in command.
- [How to concatenate string variables in Bash](https://stackoverflow.com/questions/4181703/how-to-concatenate-string-variables-in-bash/4181721#4181721):
```
foo="Hello"
foo="$foo World"
echo $foo
> Hello World
```
