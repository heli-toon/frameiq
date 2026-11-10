# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive

## Users
Casual & travel photographers, couples, and individuals taking photos in everyday scenarios (cafes, beaches, streets, parks, restaurants) who feel awkward posing, struggle with framing/composition, or want to quickly take great-looking candid and styled shots.

## Product Purpose
FrameIQ is a visual photography coach mobile application designed to eliminate composition anxiety and awkward posing. It provides real-time, interactive camera composition overlays, silhouette guides, and sensor-driven leveling right in the live viewfinder, allowing users to match their subjects to professional composition templates effortlessly.

## Positioning
Unlike generic camera apps or post-capture photo editors, FrameIQ coaches users *at the moment of capture* with contextual, scenario-based silhouette overlays (Scenes → Environments → Poses) and real-time level/tilt feedback, bridging the gap between professional photography rules and everyday casual mobile shooting.

## Operating Context
- Usage environments: Fast-paced, on-the-go real-world settings (bright sunlight at beaches, dim restaurant lighting, crowded streets, cafes).
- Dynamic shooting scenarios: Handheld mobile shooting where one person is directing or taking photos of a partner, friend, or self.
- Device hardware dependencies: Device camera feed, accelerometer/gyroscope sensors (`sensors_plus`) for level detection, local storage for favorites and captures.

## Capabilities and Constraints
- Capabilities:
  - Curated Scene → Environment → Pose hierarchy with search and filtering.
  - Live viewfinder overlay with adjustable opacity and custom silhouettes.
  - Interactive grid toggles (Rule of Thirds, Golden Ratio).
  - Sensor-driven device tilt and level indicator.
  - Local caching and persistence using Hive (Favorites, Recents, Captured photos, App preferences).
  - Clean Architecture (feature-first) with Flutter Riverpod and GoRouter.
- Constraints:
  - Local-first architecture (MVP operates completely offline without mandatory cloud sync).
  - Viewfinder performance must maintain smooth frame rates (60 FPS) with simultaneous camera feed, sensor listeners, and overlay rendering.
  - Native permissions required: Camera, Photo Library / Storage, Sensors.

## Brand Commitments
- Name: FrameIQ
- Tone: Encouraging, intuitive, clean, unobtrusive, modern.
- Visual requirement: High contrast against camera feed, clear actionable guidance without cluttering the viewfinder.

## Evidence on Hand
- Working Flutter application code with feature-first clean architecture under `lib/`.
- Mock data and domain models under `lib/shared/data/mock_data.dart` and feature domain directories.
- Existing assets for scenes, environments, poses, overlays, and onboarding in `assets/`.
- Working local persistence layer with Hive in `lib/core/services/hive_service.dart`.
- Existing light and dark theme definitions in `lib/core/theme/app_theme.dart`.

## Product Principles
1. Viewfinder First: The camera and subject are paramount; coaching elements, overlays, and controls must never obstruct the user's vision or capture reaction time.
2. In-the-Moment Guidance: Solve framing before the shutter click rather than fixing mistakes in post-processing.
3. Frictionless Flow: Transition smoothly from inspiration (scene/pose selection) into execution (camera viewfinder) in two taps or fewer.
4. Adaptive Craft: Respect platform interaction paradigms across both Android and iOS while maintaining a consistent, refined coaching experience.
