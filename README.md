# recomand.app

### Build release

'''
export PATH="$PATH:/Users/admin/development/flutter/bin"
flutter upgrade
flutter clean
flutter pub get
flutter build apk --release
or 
flutter build appbundle
'''


### make installer for windows
flutter build windows

build\windows\runner\Release
follow step by step to create installer file using Inno Setup software(https://jrsoftware.org/isdl.php)
https://protocoderspoint.com/how-to-create-exe-installation-file-of-flutter-windows-application/


### build dmg file for macos

- flutter build macos
- npm install -g appdmg

creating config.json and app_icon.icns file in installlers/dmg_creator folder in root

- appdmg <config-json-path> <output-dmg-path-with-file-name>
ex: appdmg ./config.json ./recomand.dmg