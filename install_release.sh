#/bin/sh
flutter build apk
#flutter build appbundle --target-platform android-arm,android-arm64,android-x64
adb -d install -r build/app/outputs/apk/release/app-release.apk
adb -d push build/app/outputs/apk/release/app-release.apk /sdcard/apptest/brandtnerhof.apk 

