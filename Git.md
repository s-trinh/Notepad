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
- Merge remote branchname from another repository into a branchname with `warning: refname 'remotename/branchname' is ambiguous.`, see [also](https://stackoverflow.com/questions/26046698/git-refname-origin-master-is-ambiguous#26047558):
```
git branch -a
git merge remotes/remotename/branchname
```
- Restart CI: `git commit --amend --no-edit && git push -f`
