# Blitter Flutter App


### Set up
- Setup project on your device
- FlutterFire needs to be initialized via CLI
```
# Install Firebase CLI for your platform and make sure you are logged in
# Install the FlutterFire CLI
dart pub global activate flutterfire_cli

# Run the `configure` command, select a Firebase project and platforms
flutterfire configure

# This will generate a `/lib/firebase_options.dart` file
```
- Fetch `google-services.json` and `GoogleService-Info.plist` files from Firebase Console and paste in appropriate location:
  - Android: `/android/app/google-services.json`
  - MacOS: `macos/GoogleService-Info.plist`
