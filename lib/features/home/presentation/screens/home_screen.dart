import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FrameIQ'),
        actions: [
          IconButton(
            icon: const Icon(lucide_icons.settings),
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
          _buildSectionHeader('Popular Scenes'),
          const SizedBox(height: 12),
          _buildSceneGrid(),

          const SizedBox(height: 24),

          // Recently Used
          _buildSectionHeader('Recently Used'),
          const SizedBox(height: 12),
          _buildRecentlyUsedList(),

          const SizedBox(height: 24),

          // Favorites
          _buildSectionHeader('Favorites'),
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
            icon: Icon(lucide_icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(lucide_icons.camera),
            label: 'Camera',
          ),
          NavigationDestination(
            icon: Icon(lucide_icons.images),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(lucide_icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search scenes, poses, or locations...',
          prefixIcon: const Icon(lucide_icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
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
          onPressed: () {
            // TODO: Navigate to full list
          },
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildSceneGrid() {
    // Sample scenes - in a real app, this would come from a repository
    final List<Map<String, String>> sampleScenes = [
      {
        'id': '1',
        'title': 'Beach',
        'image': 'assets/scenes/beach.jpg',
      },
      {
        'id': '2',
        'title': 'Restaurant',
        'image': 'assets/scenes/restaurant.jpg',
      },
      {
        'id': '3',
        'title': 'Cafe',
        'image': 'assets/scenes/cafe.jpg',
      },
      {
        'id': '4',
        'title': 'Street',
        'image': 'assets/scenes/street.jpg',
      },
      {
        'id': '5',
        'title': 'Park',
        'image': 'assets/scenes/park.jpg',
      },
      {
        'id': '6',
        'title': 'Mountain',
        'image': 'assets/scenes/mountain.jpg',
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleScenes.length,
        itemBuilder: (context, index) {
          final scene = sampleScenes[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(scene['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  scene['title']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentlyUsedList() {
    // Sample recently used overlays
    final List<Map<String, String>> recentOverlays = [
      {
        'id': '1',
        'title': 'Portrait Pose',
        'image': 'assets/overlays/portrait_pose.png',
      },
      {
        'id': '2',
        'title': 'Couple Pose',
        'image': 'assets/overlays/couple_pose.png',
      },
    ];

    if (recentOverlays.isEmpty) {
      return const Center(
        child: Text('No recently used overlays'),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentOverlays.length,
        itemBuilder: (context, index) {
          final overlay = recentOverlays[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(overlay['image']!),
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
                  overlay['title']!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesList() {
    // Sample favorite overlays
    final List<Map<String, String>> favoriteOverlays = [
      {
        'id': '1',
        'title': 'Golden Hour Pose',
        'image': 'assets/overlays/golden_hour.png',
      },
      {
        'id': '2',
        'title': 'Silhouette Pose',
        'image': 'assets/overlays/silhouette.png',
      },
    ];

    if (favoriteOverlays.isEmpty) {
      return const Center(
        child: Text('No favorite overlays yet'),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteOverlays.length,
        itemBuilder: (context, index) {
          final overlay = favoriteOverlays[index];
          return Padding(
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
                          image: AssetImage(overlay['image']!),
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
                          lucide_icons.star,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  overlay['title']!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}