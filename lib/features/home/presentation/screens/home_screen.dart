import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/widgets/frameiq_logo.dart';
import 'package:frameiq/core/services/hive_service.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/core/widgets/glass_nav_bar.dart';
import 'package:frameiq/features/camera/domain/models/overlay_model.dart';
import 'package:frameiq/features/camera/providers/overlay_providers.dart';
import 'package:frameiq/shared/data/mock_data.dart';
import 'package:frameiq/shared/providers/selection_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FrameIQLogo(size: 22),
            SizedBox(width: 10),
            Text('FrameIQ'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          // Super-flat Search Bar
          _buildSearchBar(),

          const SizedBox(height: 28),

          // Popular Scenes
          _buildSectionHeader('Popular Scenes', onSeeAll: () => context.push('/scenes')),
          const SizedBox(height: 12),
          _buildSceneGrid(),

          const SizedBox(height: 28),

          // Recently Used
          _buildSectionHeader('Recently Used', onSeeAll: () => context.go('/library')),
          const SizedBox(height: 12),
          _buildRecentlyUsedList(),

          const SizedBox(height: 28),

          // Favorites
          _buildSectionHeader('Favorites', onSeeAll: () => context.go('/library')),
          const SizedBox(height: 12),
          _buildFavoritesList(),
        ],
      ),
      bottomNavigationBar: GlassFloatingNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/camera');
              break;
            case 2:
              context.go('/library');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final outerBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.14)
        : const Color(0xFFE2E8F0);
    final innerBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.04);
    final outerSurfaceColor = isDark
        ? const Color(0xFF0F172A).withValues(alpha: 0.65)
        : Colors.white.withValues(alpha: 0.72);
    final innerSurfaceColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFF1F5F9).withValues(alpha: 0.75);

    return GlassSurface(
      borderRadius: BorderRadius.circular(18),
      blurSigma: 16,
      surfaceColor: outerSurfaceColor,
      borderColor: outerBorderColor,
      borderWidth: 0.8,
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: innerSurfaceColor,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: innerBorderColor,
            width: 0.6,
          ),
        ),
        child: TextField(
          onSubmitted: (val) => context.push('/overlays'),
          decoration: InputDecoration(
            isDense: true,
            filled: false,
            fillColor: Colors.transparent,
            hintText: 'Search scenes, poses, or locations...',
            hintStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
            prefixIcon: Icon(
              LucideIcons.search,
              size: 17,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                LucideIcons.sliders_horizontal,
                size: 16,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
              onPressed: () => context.push('/overlays'),
              tooltip: 'Browse Overlays',
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSceneGrid() {
    const sampleScenes = MockData.scenes;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : const Color(0xFFE2E8F0);

    return SizedBox(
      height: 124,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleScenes.length,
        itemBuilder: (context, index) {
          final scene = sampleScenes[index];
          return GestureDetector(
            onTap: () {
              ref.read(selectedSceneProvider.notifier).state = scene;
              context.push('/environments');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 82,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor,
                        width: 0.8,
                      ),
                      image: DecorationImage(
                        image: AssetImage(scene.imageAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 110,
                    child: Text(
                      scene.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentlyUsedList() {
    final hive = ref.watch(hiveServiceProvider);
    final recents = hive.getRecents();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : const Color(0xFFE2E8F0);

    final recentPoses = MockData.poses.where((p) => recents.contains(p.id)).toList();
    final itemsToDisplay = recentPoses.isNotEmpty ? recentPoses : MockData.poses.take(2).toList();

    return SizedBox(
      height: 114,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemsToDisplay.length,
        itemBuilder: (context, index) {
          final pose = itemsToDisplay[index];
          return GestureDetector(
            onTap: () {
              ref.read(selectedOverlayProvider.notifier).state = OverlayModel(
                id: pose.id,
                title: pose.title,
                overlayAsset: pose.overlayAsset,
              );
              context.go('/camera');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(pose.previewImage),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: borderColor,
                        width: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 80,
                    child: Text(
                      pose.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesList() {
    final hive = ref.watch(hiveServiceProvider);
    final favorites = hive.getFavorites();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : const Color(0xFFE2E8F0);

    final favPoses = MockData.poses.where((p) => favorites.contains(p.id)).toList();
    final itemsToDisplay = favPoses.isNotEmpty ? favPoses : MockData.poses.where((p) => p.isFavorite).toList();

    return SizedBox(
      height: 114,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemsToDisplay.length,
        itemBuilder: (context, index) {
          final pose = itemsToDisplay[index];
          return GestureDetector(
            onTap: () {
              ref.read(selectedOverlayProvider.notifier).state = OverlayModel(
                id: pose.id,
                title: pose.title,
                overlayAsset: pose.overlayAsset,
              );
              context.go('/camera');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(pose.previewImage),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.star,
                            size: 11,
                            color: Color(0xFFFBBF24), // Warm gold star
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 80,
                    child: Text(
                      pose.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
