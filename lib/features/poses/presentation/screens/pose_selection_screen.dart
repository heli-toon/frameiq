import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/domain/models/overlay_model.dart';
import 'package:frameiq/features/camera/providers/overlay_providers.dart';
import 'package:frameiq/features/poses/domain/models/pose_model.dart';
import 'package:frameiq/shared/data/mock_data.dart';
import 'package:frameiq/shared/providers/selection_providers.dart';
import 'package:frameiq/core/services/hive_service.dart';

class PoseSelectionScreen extends ConsumerWidget {
  const PoseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEnv = ref.watch(selectedEnvironmentProvider);
    final hive = ref.watch(hiveServiceProvider);

    final matchingPoses = MockData.poses.where((pose) {
      if (selectedEnv == null) return true;
      return pose.environmentId == selectedEnv.id;
    }).toList();

    final displayedPoses = matchingPoses.isNotEmpty ? matchingPoses : MockData.poses;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : const Color(0xFFE2E8F0);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEnv != null ? '${selectedEnv.title} Poses' : 'Poses & Overlays'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.74,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: displayedPoses.length,
        itemBuilder: (context, index) {
          final pose = displayedPoses[index];
          final isFav = hive.isFavorite(pose.id);
          return _buildPoseCard(context, ref, pose, isFav, borderColor);
        },
      ),
    );
  }

  Widget _buildPoseCard(
    BuildContext context,
    WidgetRef ref,
    PoseModel pose,
    bool isFav,
    Color borderColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        ref.read(selectedPoseProvider.notifier).state = pose;

        // Map pose to OverlayModel for camera reference
        final overlay = OverlayModel(
          id: pose.id,
          title: pose.title,
          overlayAsset: pose.overlayAsset,
          recommendedZoom: pose.recommendedZoom,
          recommendedTilt: pose.recommendedTilt,
          recommendedDistance: pose.recommendedDistance,
          recommendedHeight: pose.recommendedHeight,
          lightingDirection: pose.lightingDirection,
          difficulty: pose.difficulty,
          tips: pose.tips,
        );
        ref.read(selectedOverlayProvider.notifier).state = overlay;

        // Register in recents
        ref.read(hiveServiceProvider).addRecent(pose.id);

        // Go directly to camera screen
        context.go('/camera');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).cardTheme.color,
          border: Border.all(
            color: borderColor,
            width: 0.8,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black12,
                    width: double.infinity,
                    child: Image.asset(
                      pose.previewImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.10)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: borderColor,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              pose.category,
                              style: TextStyle(
                                color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF0F172A),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            pose.difficulty,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pose.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Floating Frosted Glass Favorite Button
            Positioned(
              top: 8,
              right: 8,
              child: GlassSurface.circle(
                blurSigma: 12,
                surfaceColor: Colors.black.withValues(alpha: 0.50),
                borderColor: Colors.white.withValues(alpha: 0.16),
                padding: const EdgeInsets.all(6),
                onTap: () async {
                  await ref.read(hiveServiceProvider).toggleFavorite(pose.id);
                },
                child: Icon(
                  LucideIcons.star,
                  size: 14,
                  color: isFav ? const Color(0xFFFBBF24) : Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
