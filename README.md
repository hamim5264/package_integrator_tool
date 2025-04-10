# 🛠️ Flutter Package Integration Tool

This is a developer onboarding task for **HeyFlutter.com**, designed to automate the integration of the `google_maps_flutter` package into any existing Flutter project.  
It supports full platform setup, API key configuration, and demo injection — all through a simple Flutter-based UI.

---

## ✅ Features

- 📁 **Project Picker**: Selects and validates a Flutter project directory.
- 📦 **Auto Package Integration**: Adds `google_maps_flutter` to `pubspec.yaml` and runs `flutter pub get`.
- 🔐 **Google Maps API Key Configuration**:
  - Android: Injects API key and required permissions into `AndroidManifest.xml`
  - iOS: Updates `Info.plist` with API key and location permission usage description
- 🗺️ **Google Maps Demo Injector**:
  - Adds a sample `GoogleMapPage` to the selected project
  - Replaces `main.dart` to launch the demo map (Dhaka-based)
- 🧠 Built using **Flutter + Riverpod** for clean state management

---

## 🧪 How to Use

1. **Clone this repo** and run the tool:
   ```bash
   flutter pub get
   flutter run -d windows
⚠️ Desktop support must be enabled (e.g. Windows, Linux, macOS)

Steps inside the app:

Pick a Flutter project folder (must contain pubspec.yaml)

Click "Integrate google_maps_flutter"

Enter your Google Maps API key

Click "Add API Key"

Click "Inject Google Map Example"

Open the selected project, run it, and you’ll see a working Google Map widget!

📦 Technologies Used
Flutter

Riverpod (State Management)

file_picker (Directory selection)

yaml, yaml_edit (Programmatic editing of pubspec.yaml)

Dart IO for file manipulation

🧠 Developer Notes
Due to local storage space limitations, full desktop testing could not be performed.
However, the logic, file manipulation, and integration flows are fully implemented, and can be tested on any desktop system with Flutter.

📬 Submission Info
Developer: MD. ABDUL HAMIM

Task: Developer Onboarding — Automated Package Integration

Platform: Flutter
