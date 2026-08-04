import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frameiq/core/theme/app_theme.dart';
import 'package:frameiq/core/routes/app_router.dart';
import 'package:frameiq/features/onboarding/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dotenv for environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(const ProviderScope(child: FrameIQApp()));
}

class FrameIQApp extends ConsumerWidget {
  const FrameIQApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'FrameIQ',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}