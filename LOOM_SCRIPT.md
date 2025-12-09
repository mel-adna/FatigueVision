# FatigueVision Demo Script (2 Minutes)

## Intro (0:00 - 0:20)
- **Visual**: Splash screen animating in.
- **Voiceover**: "Hi, this is [Name]. I'm excited to share FatigueVision, a robust proof-of-concept for real-time industrial fatigue detection built with Flutter and Clean Architecture."
- **Action**: App transitions effectively to Onboarding, then Home.

## Architecture & Code Quality (0:20 - 0:50)
- **Visual**: Split screen or quick flash of VS Code showing `lib/features` structure.
- **Voiceover**: "Before we dive in, under the hood, this isn't just a prototype. I've architected it for scale using Riverpod 2.0, immutable state with Freezed, and a strict separation of Domain, Data, and Presentation layers. It's 100% null-safe and testable."

## Core Feature: Detection (0:50 - 1:20)
- **Visual**: Tap "Start Detection". Camera opens.
- **Action**: You blink slowly, showing the EAR gauge drop.
- **Voiceover**: "Here's the core loop. We're using ML Kit to track facial landmarks in real-time. I implemented a custom Eye Aspect Ratio algorithm that smooths data over time to prevent noise. Notice the glassmorphism UI overlay—it stays performant even while processing video frames."

## Polish & Details (1:20 - 1:45)
- **Visual**: Navigate to History, generate PDF. Toggle Settings (Dark/Light).
- **Voiceover**: "Beyond the AI, I focused on the complete product experience. We have local history storage, one-tap PDF export for compliance reporting, and full internationalization support."

## Outro (1:45 - 2:00)
- **Visual**: Return to Home Screen.
- **Voiceover**: "FatigueVision demonstrates that we can build critical safety tools that are both reliable and beautiful. Thanks for watching."
