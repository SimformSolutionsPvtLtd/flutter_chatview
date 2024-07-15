1. Add dependencies to `pubspec.yaml`

   Get the latest version in the 'Installing' tab
   on [pub.dev](https://pub.dev/packages/chatview/install)

    ```yaml
    dependencies:
        chatview: <latest-version>
    ```

2. Run pub get.

   ```shell
   flutter pub get
   ```

3. Import package.

    ```dart
    import 'package:chatview/chatview.dart';
    ```

## Messages types compability

|Message Types   | Android | iOS | MacOS | Web | Linux | Windows |
| :-----:        | :-----: | :-: | :---: | :-: | :---: | :-----: |
|Text messages   |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |
|Image messages  |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |
|Voice messages  |   ✔️    | ✔️  |  ❌   | ❌  |  ❌  |   ❌  |
|Custom messages |   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |

## Platform specific configuration

### For image Picker
#### iOS
* Add the following keys to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

```
    <key>NSCameraUsageDescription</key>
    <string>Used to demonstrate image picker plugin</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Used to capture audio for image picker plugin</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Used to demonstrate image picker plugin</string>
```

### For voice messages
#### iOS
* Add this two rows in `ios/Runner/Info.plist`
```
    <key>NSMicrophoneUsageDescription</key>
    <string>This app requires Mic permission.</string>
```
* This plugin requires ios 10.0 or higher. So add this line in `Podfile`
```
    platform :ios, '10.0'
```

#### Android
* Change the minimum Android sdk version to 21 (or higher) in your android/app/build.gradle file.
```
    minSdkVersion 21
```

* Add RECORD_AUDIO permission in `AndroidManifest.xml`
```
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
```