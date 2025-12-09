# FatigueVision 4.0

![FatigueVision Mockup](./fatigue_vision_mockup.jpeg)

**FatigueVision** is a production-grade Proof of Concept (POC) for real-time industrial fatigue detection. Built with Flutter, it leverages on-device Machine Learning (ML Kit) to monitor driver alertness through Eye Aspect Ratio (EAR) analysis.

This project demonstrates **Senior-Level Flutter Development** practices, including Clean Architecture, Riverpod for state management, and strict separation of concerns.

## 🚀 Key Features

*   **Real-Time Detection**: Analyzes facial landmarks at 10-30 FPS to detect drowsiness.
*   **Industrial Design**: High-contrast, glassmorphism UI optimized for visibility.
*   **Smart History**: Tracks fatigue events locally and provides trends.
*   **Compliance Ready**: One-tap PDF export for safety logs.
*   **Internationalization**: Fully localized (English/Arabic).

## 🛠 Tech Stack

*   **Architecture**: Clean Architecture (Domain, Data, Presentation)
*   **State Management**: `flutter_riverpod` (v2.0+) with code generation
*   **DI**: `get_it` + `injectable`
*   **ML**: `google_mlkit_face_detection`
*   **Data Models**: `freezed` + `json_serializable`
*   **Navigation**: `go_router`
*   **Testing**: `flutter_test`, `mocktail`
*   **Lints**: `very_good_analysis`

## 🏗 Directory Structure

```
lib/
├── app/            # App entry point & global providers
├── config/         # Routing, DI, Theme setup
├── core/           # Shared utilities (Extensions, Widgets, Services)
├── features/       # Feature-based modules (Clean Arch)
│   ├── fatigue/    # Logic for detection (Camera, ML, EAR)
│   ├── history/    # Storage & PDF generation
│   ├── onboarding/ # Intro flow
│   └── settings/   # Theme & Locale
└── l10n/           # ARB Localization files
```

## ⚡ Getting Started

1.  **Prerequisites**: Flutter SDK (Stable), Android Studio / VS Code.
2.  **Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Code Generation** (Required for DI/Riverpod):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Run**:
    ```bash
    flutter run
    ```

## 🧪 Testing

Run the comprehensive test suite:
```bash
flutter test
```

## 📦 Deliverables
- [x] Full Source Code
- [x] APK Ready (run `flutter build apk`)
- [x] Loom Video Script (`LOOM_SCRIPT.md`)
- [x] Design Assets

---
*Built by [Your Name] for [Company Name].*
# FatigueVision
# FatigueVision
