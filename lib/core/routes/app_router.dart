import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frameiq/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:frameiq/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:frameiq/features/home/presentation/screens/home_screen.dart';
import 'package:frameiq/features/scenes/presentation/screens/scene_selection_screen.dart';
import 'package:frameiq/features/environments/presentation/screens/environment_selection_screen.dart';
import 'package:frameiq/features/poses/presentation/screens/pose_selection_screen.dart';
import 'package:frameiq/features/overlays/presentation/screens/overlay_browser_screen.dart';
import 'package:frameiq/features/camera/presentation/screens/camera_screen.dart';
import 'package:frameiq/features/camera/presentation/screens/capture_review_screen.dart';
import 'package:frameiq/features/library/presentation/screens/library_screen.dart';
import 'package:frameiq/features/settings/presentation/screens/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Home
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Scene Selection
      GoRoute(
        path: '/scenes',
        builder: (context, state) => const SceneSelectionScreen(),
      ),

      // Environment Selection
      GoRoute(
        path: '/environments',
        builder: (context, state) => const EnvironmentSelectionScreen(),
      ),

      // Pose Selection
      GoRoute(
        path: '/poses',
        builder: (context, state) => const PoseSelectionScreen(),
      ),

      // Overlay Browser
      GoRoute(
        path: '/overlays',
        builder: (context, state) => const OverlayBrowserScreen(),
      ),

      // Camera
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraScreen(),
      ),

      // Capture Review
      GoRoute(
        path: '/review',
        builder: (context, state) {
          final imagePath = state.extra as String? ?? '';
          return CaptureReviewScreen(imagePath: imagePath);
        },
      ),

      // Library
      GoRoute(
        path: '/library',
        builder: (context, state) => const LibraryScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    redirect: (context, state) {
      return null;
    },
  );
});