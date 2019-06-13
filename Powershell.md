### Powershell
- [Find Files Larger than a Specific Size with PowerShell & CMD](https://sumtips.com/tips-n-tricks/find-files-larger-than-a-specific-size-with-powershell-command-prompt/):
```
Get-ChildItem C:\ -recurse | where-object {$_.length -gt 524288000} | Sort-Object length | ft fullname, length -auto
```
- add extension to filename:
```
gci | ren -new {$_.name + ".jpg"}
# or
Ren *.* *.jpg
```