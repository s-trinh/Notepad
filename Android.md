## Misc
- [OpenCV in Android Studio](https://stackoverflow.com/questions/27406303/opencv-in-android-studio/27421494)
- [Run apps on the Android Emulator](https://developer.android.com/studio/run/emulator)
- [Android SDK - Install system image packages offline](https://stackoverflow.com/questions/36501550/android-sdk-install-system-image-packages-offline/43430619#43430619): (needed x86 for ViSP Android SDK and emulator)
> https://dl.google.com/android/repository/sys-img/google_apis/x86-27_r06.zip
- [Write and View Logs with Logcat](https://developer.android.com/studio/debug/am-logcat)
- [Session 'app' error while installing APK](https://stackoverflow.com/questions/38450717/session-app-error-while-installing-apk/42617107#42617107) (encountered error)
- [[INSTALL_FAILED_NO_MATCHING_ABIS: Failed to extract native libraries, res=-113]](https://stackoverflow.com/questions/36414219/install-failed-no-matching-abis-failed-to-extract-native-libraries-res-113/49473570#49473570) (encountered error):
```
    splits {
        abi {
            enable true
            reset()
            include 'x86', 'armeabi-v7a', 'arm64-v8a'
            universalApk true
        }
    }
```
- [[x86][houdini] UnsatisfiedLinkError when running on Android devices with x86 processors #12246](https://github.com/facebook/react-native/issues/12246)?
- [Cache invalid retry (internally handled)](https://bugs.launchpad.net/ubuntu/+source/nautilus/+bug/1268015): **use a better USB cable**
- [android - How to draw a Line on Canvas](https://android--code.blogspot.com/2015/11/android-how-to-draw-line-on-canvas.html)
- Camera preview image format:
  - [How to get Android camera preview data?](https://stackoverflow.com/questions/17682345/how-to-get-android-camera-preview-data)
  - [ImageFormat](https://developer.android.com/reference/android/graphics/ImageFormat.html)
  - [Extract black and white image from android camera's NV21 format](https://stackoverflow.com/questions/5272388/extract-black-and-white-image-from-android-cameras-nv21-format)
  - [android camera’s NV21 format](https://gist.github.com/melvincabatuan/890d93270a45694e173f)
- [How to stop logcat from scrolling in Android Studio](https://stackoverflow.com/questions/19458738/how-to-stop-logcat-from-scrolling-in-android-studio/28037147#28037147)
- Information about phone hardware: [Droid Hardware Info](https://play.google.com/store/apps/details?id=com.inkwired.droidinfo&hl=en)
- Android SDK + ViSP Android demos:
  - Copy lib into `app/src/main/jniLibs/` + hardware architecture type (`x86`, `x86_64`, `arm64-v8a`, ...)
  - [instructions](https://github.com/lagadic/visp/pull/404#issuecomment-411296491)
- [How to install Android Studio on Ubuntu?](https://askubuntu.com/questions/634082/how-to-install-android-studio-on-ubuntu)
