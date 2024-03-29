# Grocery Shopper

A sample Flutter app.

## Project Setup

1. Download/install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Install [Android Studio](https://developer.android.com/studio). You can use Visual Studio Code with extensions as well, but you'll find Android Studio to have more comprehensive support for mobile (particularly Android) development with Flutter.
3. Start Android Studio, select "Plugins" from the left panel, and install the Flutter plugin. This will also install the Dart plugin.
4. Optional: if you want to test your app on an iOS device and have a Mac, then follow [these instructions](https://docs.flutter.dev/get-started/install/macos/mobile-ios) for setting up XCode and other necessary tools.
5. Open this project in Android Studio. You may get prompts to enable Dart support for the project and/or to run `pub get` to get dependencies, both of which you should do.

## Important Files/Folders

* `pubspec.yaml` contains metadata about the project, such as libraries it uses and assets to be included in the app. We will start with the one generated for us by creating a new Flutter project and customize it as we add new features and integrations.
  * `pubspec.lock` contains additional, more precise details about parts of `pubspec.yaml`. We will rely on the `pub` command to manage this file for us. 
* `lib` will contain all of the Dart code that will go directly into our app.
* `test` is where we will place our unit and widget tests.
* `android`, `ios`, `linux`, `macos`, `web`, and `windows` contain files related to building our app for those specific platforms, including any native wrapper code. We won't be touching these folders except to add additional platform-specific configuration.

