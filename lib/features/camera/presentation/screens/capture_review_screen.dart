import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';

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

          // Header with floating frosted glass close button
          Positioned(
            top: 50,
            left: 16,
            child: GlassSurface.circle(
              blurSigma: 14,
              surfaceColor: Colors.black.withValues(alpha: 0.50),
              borderColor: Colors.white.withValues(alpha: 0.16),
              padding: const EdgeInsets.all(10),
              onTap: () => context.pop(),
              child: const Icon(
                LucideIcons.x,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          // Bottom Bar Actions (Floating Glass Capsule)
          Positioned(
            bottom: 34,
            left: 20,
            right: 20,
            child: GlassSurface.pill(
              blurSigma: 18,
              surfaceColor: Colors.black.withValues(alpha: 0.65),
              borderColor: Colors.white.withValues(alpha: 0.16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Retake
                  TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(LucideIcons.refresh_cw, color: Colors.white70, size: 16),
                    label: const Text(
                      'Retake',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  // Save Photo CTA
                  ElevatedButton.icon(
                    onPressed: _isSaved ? null : _savePhoto,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: _isSaved
                          ? const Color(0xFF10B981)
                          : Colors.white,
                      foregroundColor: _isSaved
                          ? Colors.white
                          : const Color(0xFF090D16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    icon: Icon(
                      _isSaved ? LucideIcons.check : LucideIcons.download,
                      size: 16,
                    ),
                    label: Text(
                      _isSaved ? 'Saved' : 'Save Photo',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),

                  // Go to Library
                  IconButton(
                    onPressed: () => context.go('/library'),
                    icon: const Icon(LucideIcons.images, color: Colors.white70, size: 20),
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
