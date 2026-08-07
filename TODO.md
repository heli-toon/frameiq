# TODO: FrameIQ Development Progress

## Completed
- [x] Initialize Flutter project with latest stable version
- [x] Set up project structure following Clean Architecture (feature-first)
- [x] Added dependencies: flutter_riverpod, go_router, hive, camera, sensors_plus, etc.
- [x] Created basic app theme (light/dark) with Material 3
- [x] Set up routing with GoRouter (all routes + /review screen)
- [x] Implemented Splash Screen
- [x] Implemented Onboarding Screens (3 pages)
- [x] Implemented Home Screen connected with Riverpod and Hive
- [x] Complete Camera Feature:
    - [x] Domain: OverlayModel (freezed)
    - [x] Application: CameraController (Riverpod) with camera initialization, capture, flash, zoom
    - [x] Application: OverlaySettings (opacity), ZoomLevel, GridSettings providers
    - [x] Presentation: CameraScreen (scaffold with stack)
    - [x] Presentation: CompositionOverlay with active overlay loading
    - [x] Presentation: GridOverlay (Rule of Thirds / Golden Ratio toggle)
    - [x] Presentation: LevelIndicator (using sensors_plus for device tilt)
    - [x] Presentation: CameraControls (flash, capture, grid toggle, zoom slider, opacity slider)
    - [x] Presentation: RecommendationHeader (zoom, distance, tilt display)
    - [x] Presentation: CaptureReviewScreen (show captured image, save to library, retake)
- [x] Implemented Interactive Screens:
    - [x] Scenes Selection Screen (interactive grid with search)
    - [x] Environments Selection Screen (interactive list for selected scene)
    - [x] Poses Selection Screen (grid with difficulty & favorite stars)
    - [x] Overlay Browser Screen (search & filter by difficulty)
    - [x] Library Screen (Tabs for Saved Photos, Favorites, Recents)
    - [x] Settings Screen (Grid defaults, Opacity slider, Clear data, App info)
- [x] Implement Data Models (Freezed + JSON):
    - [x] Scene model (id, title, description, imageAsset, environmentsCount)
    - [x] Environment model (id, sceneId, title, imageAsset, posesCount)
    - [x] Pose model (id, environmentId, title, category, previewImage, overlayAsset, difficulty, instructions)
- [x] Implement Repositories & Hive Local Persistence:
    - [x] Created shared MockData set for scenes, environments, poses, overlays
    - [x] Set up Hive boxes for favorites, recently used, app preferences, captured photos
    - [x] Created HiveService provider
- [x] Implement Navigation Flow (Scene -> Environment -> Pose -> Camera)
- [x] Implement Favorites and Recently Used functionality (Hive)
- [x] Implement Overlay Selection and Passing to Camera
- [x] Add Asset Images & Overlays
- [x] Optimize Performance (const constructors, clean state handling)
- [x] Write Unit and Widget Tests (Passing widget tests)
- [x] Clean static analysis (0 analyzer warnings/errors)

## In Progress
- [ ] Ensure App Works on Physical Android and iOS devices

## Future Enhancements (Post-MVP)
- [ ] Cloud synchronization (Firebase) for overlays and user data
- [ ] User authentication and accounts
- [ ] AI-powered pose detection and feedback
- [ ] Advanced camera controls (manual focus, ISO, shutter speed)
- [ ] Social sharing features
- [ ] Photo editing basics (filters, cropping)
- [ ] Analytics (privacy-first)
- [ ] Multi-language support
- [ ] Accessibility improvements

## Future Enhancements (Post-MVP)
- [ ] Cloud synchronization (Firebase) for overlays and user data
- [ ] User authentication and accounts
- [ ] AI-powered pose detection and feedback
- [ ] Advanced camera controls (manual focus, ISO, shutter speed)
- [ ] Social sharing features
- [ ] Photo editing basics (filters, cropping)
- [ ] Analytics (privacy-first)
- [ ] Multi-language support
- [ ] Accessibility improvements

## Notes
- The camera feature is the core MVP and should be prioritized for completion.
- All business logic should reside in domain/application layers, not in widgets.
- Follow Effective Dart guidelines and use immutable models with freezed.
- Keep UI components reusable and composable.
- Ensure smooth performance (60 FPS) with efficient lists/grids.