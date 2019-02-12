## Shortcuts
- [Go to matching bracket](http://lists.qt-project.org/pipermail/qt-creator/2013-April/002072.html)
> [Qt-creator] brace matching
>
> David Schulz david.schulz at digia.com 
> Mon Apr 22 14:58:21 CEST 2013
> Previous message: [Qt-creator] brace matching
> Next message: [Qt-creator] brace matching
> Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> Hi,
>
> try the shortcuts GotoBlockStart and GotoBlockEnd (default "ctrl + ["
> and "ctrl+]").
> There are also shortcuts to select the text untill the block start or
> end (default "ctrl+{" and "ctrl+}").
>
> br
> david
>
> Am 4/22/2013 5:45 AM, schrieb Duane:
> > Is there a way to jump from opening brace to closing brace and vice
> > versa?  I can select one and the other is highlighted.  Using 2.6.2.
> >
> > _______________________________________________
> > Qt-creator mailing list
> > Qt-creator at qt-project.org
> > http://lists.qt-project.org/mailman/listinfo/qt-creator
- [Keyboard Shortcuts](https://doc.qt.io/qtcreator/creator-keyboard-shortcuts.html)
- [Qt Creator: Multi line text editing](https://stackoverflow.com/questions/17320056/qt-creator-multi-line-text-editing/23652683#23652683): `hold shift + alt > move cursor to the multi lines selection > type`

## Install
- [Qt Offline Installers](https://www1.qt.io/offline-installers/)
- [How to add programs to the Unity Launcher or Ubuntu Dock?](https://askubuntu.com/questions/224004/how-to-add-programs-to-the-unity-launcher-or-ubuntu-dock/224021#224021):
```
~/.local/share/applications
/usr/share/applications

[Desktop Entry]
Type=Application
Exec=/local/user/Qt5.11.2/Tools/QtCreator/bin/qtcreator
Name=Qt Creator (Community)
GenericName=The IDE of choice for Qt development.
Icon=QtProject-qtcreator
StartupWMClass=qtcreator
Terminal=false
Categories=Development;IDE;Qt;
MimeType=text/x-c++src;text/x-c++hdr;text/x-xsrc;application/x-designer;application/vnd.qt.qmakeprofile;application/vnd.qt.xml.resource;text/x-qml;text/x-qt.qml;text/x-qt.qbs;
```
