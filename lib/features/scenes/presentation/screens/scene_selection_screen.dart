import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SceneSelectionScreen extends ConsumerWidget {
  const SceneSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scene Selection'),
      ),
      body: const Center(
        child: Text('Scene Selection Screen - Coming Soon'),
      ),
    );
  }
}