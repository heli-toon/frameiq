import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';

class CaptureReviewScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const CaptureReviewScreen({super.key, required this.imagePath});

  @override
  ConsumerState<CaptureReviewScreen> createState() => _CaptureReviewScreenState();
}

class _CaptureReviewScreenState extends ConsumerState<CaptureReviewScreen> {
  bool _isSaved = false;

  Future<void> _savePhoto() async {
    final hive = ref.read(hiveServiceProvider);
    await hive.addCapturedPhoto(widget.imagePath);
    setState(() {
      _isSaved = true;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo saved to FrameIQ Library!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Captured Image View
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.contain,
          ),

          // Header with back / close
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(LucideIcons.x, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ),

          // Bottom Bar Actions (Retake, Save, Library)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Retake
                  TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(LucideIcons.refresh_cw, color: Colors.white),
                    label: const Text('Retake', style: TextStyle(color: Colors.white)),
                  ),

                  // Save Photo
                  ElevatedButton.icon(
                    onPressed: _isSaved ? null : _savePhoto,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSaved ? Colors.grey : Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    icon: Icon(_isSaved ? LucideIcons.check : LucideIcons.download, color: Colors.white),
                    label: Text(_isSaved ? 'Saved' : 'Save Photo', style: const TextStyle(color: Colors.white)),
                  ),

                  // Go to Library
                  IconButton(
                    onPressed: () => context.go('/library'),
                    icon: const Icon(LucideIcons.images, color: Colors.white),
                    tooltip: 'Go to Library',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
