import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';
import 'package:frameiq/features/camera/domain/models/overlay_model.dart';
import 'package:frameiq/features/camera/providers/overlay_providers.dart';
import 'package:frameiq/shared/data/mock_data.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hive = ref.watch(hiveServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FrameIQ Library'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(LucideIcons.camera), text: 'Photos'),
            Tab(icon: Icon(LucideIcons.star), text: 'Favorites'),
            Tab(icon: Icon(LucideIcons.history), text: 'Recents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPhotosTab(hive),
          _buildFavoritesTab(hive),
          _buildRecentsTab(hive),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2, // Library tab
        onDestinationSelected: (index) {
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
          NavigationDestination(icon: Icon(LucideIcons.house), label: 'Home'),
          NavigationDestination(icon: Icon(LucideIcons.camera), label: 'Camera'),
          NavigationDestination(icon: Icon(LucideIcons.images), label: 'Library'),
          NavigationDestination(icon: Icon(LucideIcons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildPhotosTab(HiveService hive) {
    final photos = hive.getCapturedPhotos();

    if (photos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.image_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No photos saved in FrameIQ yet.'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/camera'),
              icon: const Icon(LucideIcons.camera),
              label: const Text('Take a Photo'),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final path = photos[index];
        return GestureDetector(
          onTap: () => context.push('/review', extra: path),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(
                color: Colors.grey.shade300,
                child: const Icon(LucideIcons.image_off),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab(HiveService hive) {
    final favIds = hive.getFavorites();
    final favoritePoses = MockData.poses.where((p) => favIds.contains(p.id)).toList();

    if (favoritePoses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.star, size: 48, color: Colors.amber),
            const SizedBox(height: 16),
            const Text('No favorite poses saved.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/scenes'),
              child: const Text('Browse Scenes'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoritePoses.length,
      itemBuilder: (context, index) {
        final pose = favoritePoses[index];
        return ListTile(
          leading: Image.asset(pose.previewImage, width: 48, height: 48, fit: BoxFit.cover),
          title: Text(pose.title),
          subtitle: Text('${pose.category} • ${pose.difficulty}'),
          trailing: const Icon(LucideIcons.camera),
          onTap: () {
            ref.read(selectedOverlayProvider.notifier).state = OverlayModel(
              id: pose.id,
              title: pose.title,
              overlayAsset: pose.overlayAsset,
            );
            context.go('/camera');
          },
        );
      },
    );
  }

  Widget _buildRecentsTab(HiveService hive) {
    final recentIds = hive.getRecents();
    final recentPoses = MockData.poses.where((p) => recentIds.contains(p.id)).toList();

    if (recentPoses.isEmpty) {
      return const Center(
        child: Text('No recently used compositions.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recentPoses.length,
      itemBuilder: (context, index) {
        final pose = recentPoses[index];
        return ListTile(
          leading: Image.asset(pose.previewImage, width: 48, height: 48, fit: BoxFit.cover),
          title: Text(pose.title),
          subtitle: Text(pose.category),
          trailing: const Icon(LucideIcons.chevron_right),
          onTap: () {
            ref.read(selectedOverlayProvider.notifier).state = OverlayModel(
              id: pose.id,
              title: pose.title,
              overlayAsset: pose.overlayAsset,
            );
            context.go('/camera');
          },
        );
      },
    );
  }
}