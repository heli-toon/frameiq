# TODO: FrameIQ Development Progress

## Completed
- [x] Initialize Flutter project with latest stable version
- [x] Set up project structure following Clean Architecture (feature-first)
- [x] Added dependencies: flutter_riverpod, go_router, hive, camera, sensors_plus, etc.
- [x] Created basic app theme (light/dark) with Material 3
- [x] Set up routing with GoRouter (basic routes)
- [x] Implemented Splash Screen
- [x] Implemented Onboarding Screens (3 pages)
- [x] Implemented Home Screen with search, popular scenes, recently used, favorites
- [x] Started Camera Feature:
    - [x] Domain: OverlayModel (freezed)
    - [x] Application: CameraController (Riverpod) with camera initialization, capture, flash, zoom
    - [x] Application: OverlaySettings (opacity), ZoomLevel providers
    - [x] Presentation: CameraScreen (scaffold with stack)
    - [x] Presentation: CompositionOverlay (placeholder)
    - [x] Presentation: LevelIndicator (using sensors_plus for device tilt)
    - [x] Presentation: CameraControls (flash, capture, gallery, zoom slider)
    - [x] Presentation: RecommendationHeader (zoom, distance, tilt display)

## In Progress
- [ ] Complete Camera Feature:
    - [x] Connect overlay opacity slider to OverlaySettings provider
    - [ ] Implement actual overlay loading based on selected overlay
    - [ ] Implement capture review screen (show captured image, save/retake/share/favorite)
    - [x] Implement proper zoom control (sync between slider and camera controller)
    - [ ] Add grid toggle (rule of thirds overlay)
    - [x] Add flash state indicator in UI
- [ ] Implement Data Models:
    - [ ] Scene model (id, title, thumbnail, description)
    - [ ] Environment model (id, sceneId, title, thumbnail)
    - [ ] Pose model (id, category, previewImage, difficulty)
- [ ] Implement Repositories (local data):
    - [ ] Create mock JSON data in assets for scenes, environments, poses, overlays
    - [ ] Set up Hive boxes for favorites, recently used, app preferences
    - [ ] Create repository interfaces and implementations (local data source)
- [ ] Implement Remaining Screens:
    - [ ] Scenes Selection Screen (grid of scenes)
    - [ ] Environments Selection Screen (grid of environments for selected scene)
    - [ ] Poses Selection Screen (grid of poses)
    - [ ] Overlay Browser Screen (search, filter, sort overlays)
    - [ ] Library Screen (favorites and recently used overlays)
    - [ ] Settings Screen (dark/light mode, about, privacy, version)
- [ ] Implement Navigation Flow:
   
- [ ] Implement Favorites and Recently Used functionality (Hive)
- [ ] Implement Overlay Selection and Passing to Camera
- [ ] Add Asset Images (placeholder overlays, scenes, etc.)
- [ ] Add Animations and Transitions between screens
- [ ] Optimize Performance (lazy loading, const constructors, etc.)
- [ ] Write Unit and Widget Tests
- [ ] Polish UI/UX (spacing, typography, responsiveness)
- [ ] Ensure App Works on Android and iOS (test on emulators/devices)

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