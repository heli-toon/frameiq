import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';
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
      appBar: AppBar(
        title: const Text('FrameIQ'),
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
        padding: const EdgeInsets.all(16),
        children: [
          // Search Bar
          _buildSearchBar(),

          const SizedBox(height: 24),

          // Popular Scenes
          _buildSectionHeader('Popular Scenes', onSeeAll: () => context.push('/scenes')),
          const SizedBox(height: 12),
          _buildSceneGrid(),

          const SizedBox(height: 24),

          // Recently Used
          _buildSectionHeader('Recently Used', onSeeAll: () => context.go('/library')),
          const SizedBox(height: 12),
          _buildRecentlyUsedList(),

          const SizedBox(height: 24),

          // Favorites
          _buildSectionHeader('Favorites', onSeeAll: () => context.go('/library')),
          const SizedBox(height: 12),
          _buildFavoritesList(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
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
        destinations: const [
          NavigationDestination(
            icon: Icon(LucideIcons.house),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.camera),
            label: 'Camera',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.images),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onSubmitted: (val) => context.push('/overlays'),
        decoration: const InputDecoration(
          hintText: 'Search scenes, poses, or locations...',
          prefixIcon: Icon(LucideIcons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildSceneGrid() {
    const sampleScenes = MockData.scenes;

    return SizedBox(
      height: 120,
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
                children: [
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(scene.imageAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scene.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

    final recentPoses = MockData.poses.where((p) => recents.contains(p.id)).toList();
    final itemsToDisplay = recentPoses.isNotEmpty ? recentPoses : MockData.poses.take(2).toList();

    return SizedBox(
      height: 110,
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
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pose.title,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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

    final favPoses = MockData.poses.where((p) => favorites.contains(p.id)).toList();
    final itemsToDisplay = favPoses.isNotEmpty ? favPoses : MockData.poses.where((p) => p.isFavorite).toList();

    return SizedBox(
      height: 110,
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
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.star,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pose.title,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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