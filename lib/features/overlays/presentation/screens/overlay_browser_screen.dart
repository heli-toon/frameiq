import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverlayBrowserScreen extends ConsumerWidget {
  const OverlayBrowserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Browser'),
      ),
      body: const Center(
        child: Text('Overlay Browser Screen - Coming Soon'),
      ),
    );
  }
}