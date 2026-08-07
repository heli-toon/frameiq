import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/core/theme/app_theme.dart';
import 'package:frameiq/core/routes/app_router.dart';
import 'package:frameiq/core/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive storage boxes
  await HiveService.init();

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