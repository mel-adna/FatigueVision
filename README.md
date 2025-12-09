# FatigueVision - Driver Safety System

FatigueVision is a real-time mobile application designed to detect driver drowsiness and prevent accidents using computer vision and machine learning.

![App Screenshot](assets/images/app_icon.png)

## 🛠️ Technology Stack

This project is built using **Flutter** and leverages several powerful libraries to ensure performance and reliability:

- **Framework**: [Flutter](https://flutter.dev/) (SDK ^3.10.1)
- **Language**: Dart
- **State Management**: [Riverpod](https://riverpod.dev/) (`flutter_riverpod`, `riverpod_annotation`)
- **Computer Vision**: [Google ML Kit](https://developers.google.com/ml-kit) (`google_mlkit_face_detection`)
- **Hardware Access**:
  - `camera`: For real-time video feed.
  - `audioplayers`: For audio alerts.
  - `vibration`: For haptic feedback.
  - `wakelock_plus`: To keep the screen awake during monitoring.
- **Architecture**: Domain-Driven Design (DDD) principles with Dependency Injection (`injectable`, `get_it`).
- **Navigation**: `go_router` for deep linking and declarative routing.
- **Charts**: `fl_chart` for visualizing fatigue history.

## 🧠 How It Works (The Logic)

The core functionality revolves around the **Eye Aspect Ratio (EAR)**, a scalar value that indicates the openness of the eye.

### 1. Face Detection & Landmark Extraction
The app uses **Google ML Kit** to detect faces in real-time from the camera stream. For each detected face, it extracts specific **landmarks** (points on the face), specifically focusing on the contours of the eyes.

### 2. Eye Aspect Ratio (EAR) Calculation
The EAR is calculated using the distances between specific points on the eyelid contours:

```dart
EAR = (||p2-p6|| + ||p3-p5||) / (2 * ||p1-p4||)
```
- **Vertical Distances**: The distance between the top and bottom eyelids (p2-p6 and p3-p5).
- **Horizontal Distance**: The distance between the left and right corners of the eye (p1-p4).

When an eye is open, the EAR is relatively constant. When an eye closes (blinks or drowsiness), the vertical distance decreases towards zero, causing the EAR to drop significantly.

### 3. Smoothing & Thresholds
To prevent false positives from normal blinking, we calculate a rolling average of the EAR over the last 10 frames.

This smoothed EAR is then compared against a configurable sensitivity threshold:
- **Low Sensitivity**: Threshold < 0.18 (Requires eyes to be very closed)
- **Medium Sensitivity**: Threshold < 0.22 (Default)
- **High Sensitivity**: Threshold < 0.26 (More sensitive to slight drooping)

### 4. Alert System
If the EAR drops below the threshold for a sustained period (indicating drowsiness rather than a blink), the app triggers an alert:
- **Audio**: Plays a loud alarm sound.
- **Haptic**: Vibrates the device.
- **Visual**: The UI flashes red.

## 🤖 Interaction with Machine Learning (ML)

While this app does not use a Generative Large Language Model (LLM) for its core detection logic, it relies heavily on **On-Device Machine Learning**.

1.  **Input**: The raw camera frame (YUV/NV21 format) is captured.
2.  **Preprocessing**: The image is converted to an `InputImage` format compatible with ML Kit, handling rotation and metadata.
3.  **Inference**: The **ML Kit Face Detection** model runs on the device's NPU/CPU. It inference the image to find face bounding boxes and 2D landmarks.
4.  **Output**: The model returns a list of faces with coordinates for eyes, nose, mouth, etc., which our `EARCalculator` uses.

This on-device approach ensures:
- **Privacy**: No video data leaves the phone.
- **Speed**: Real-time processing (30+ FPS) without network latency.
- **Offline Capability**: Works perfectly without an internet connection.

## 📝 Summary

**FatigueVision** is a robust safety tool that combines modern mobile development (Flutter) with efficient on-device Machine Learning (Google ML Kit). By continuously analyzing facial landmarks and calculating the Eye Aspect Ratio, it serves as a vigilant co-pilot, alerting drivers the moment signs of fatigue are detected.
