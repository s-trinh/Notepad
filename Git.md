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
- [Git Workflow: Without a server](https://stackoverflow.com/questions/5947064/git-workflow-without-a-server/5947423#5947423), [How to add a local repo and treat it as a remote repo](https://stackoverflow.com/questions/10603671/how-to-add-a-local-repo-and-treat-it-as-a-remote-repo/34507038#34507038):
```
git init --bare ~/repos/myproject.git
cd /path/to/existing/repo
git init
git remote add origin ~/repos/myproject.git
git push origin master
git remote add upstream https://github.com/profile/repository.git
git push upstream master
```
- [Undo a Git merge that hasn't been pushed yet](https://stackoverflow.com/questions/2389361/undo-a-git-merge-that-hasnt-been-pushed-yet):
```
git reflog
git reset --hard commit_sha
# or
git reset --hard origin/master
```
- [Git clone recursive over https](https://stackoverflow.com/questions/11410017/git-submodule-update-over-https/11410074#11410074):
```
Edit your `.gitmodule` file
git submodule sync # to reflect the change to your .git/config file
git submodule update --recursive
git submodule update --init --recursive # first time you checkout a repo you need to use --init first
```
- [How do you remove an invalid remote branch reference from Git?](https://stackoverflow.com/questions/1072171/how-do-you-remove-an-invalid-remote-branch-reference-from-git/8255687#8255687) (for example: origin url has been changed, for a manual fork + upstream, to update a remote fork repo from a local repo cloned from upstream): `git fetch -p`
- [Git push branch from one remote to another?](https://stackoverflow.com/questions/7818927/git-push-branch-from-one-remote-to-another/21133502#21133502) (for example: origin url has been changed, for a manual fork + upstream, to update a remote fork repo from a local repo cloned from upstream):
```
git push origin 'refs/remotes/upstream/*:refs/heads/*'
git push origin 'refs/tags/*:refs/tags/*'
```
- [Setting up and using Meld as your git difftool and mergetool](https://stackoverflow.com/questions/34119866/setting-up-and-using-meld-as-your-git-difftool-and-mergetool/34119867#34119867):
```
# Add the following to your .gitconfig file.
[diff]
    tool = meld
[difftool]
    prompt = false
[difftool "meld"]
    cmd = meld "$LOCAL" "$REMOTE"
```
