import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEnv != null ? '${selectedEnv.title} Poses' : 'Poses & Overlays'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: displayedPoses.length,
        itemBuilder: (context, index) {
          final pose = displayedPoses[index];
          final isFav = hive.isFavorite(pose.id);
          return _buildPoseCard(context, ref, pose, isFav);
        },
      ),
    );
  }

  Widget _buildPoseCard(BuildContext context, WidgetRef ref, PoseModel pose, bool isFav) {
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
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardTheme.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
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
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              pose.category,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            pose.difficulty,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pose.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Favorite Button
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black54,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    isFav ? LucideIcons.star : LucideIcons.star,
                    size: 16,
                    color: isFav ? Colors.amber : Colors.white70,
                  ),
                  onPressed: () async {
                    await ref.read(hiveServiceProvider).toggleFavorite(pose.id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}