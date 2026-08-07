import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentSelectionScreen extends ConsumerWidget {
  const EnvironmentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment Selection'),
      ),
      body: const Center(
        child: Text('Environment Selection Screen - Coming Soon'),
      ),
    );
  }
}