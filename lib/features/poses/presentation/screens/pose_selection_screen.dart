import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoseSelectionScreen extends ConsumerWidget {
  const PoseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Selection'),
      ),
      body: const Center(
        child: Text('Pose Selection Screen - Coming Soon'),
      ),
    );
  }
}