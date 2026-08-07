import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final hive = ref.watch(hiveServiceProvider);
    final currentGrid = ref.watch(gridSettingsProvider);
    final currentOpacity = ref.watch(overlaySettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Camera Settings Section
          _buildSectionHeader('Camera & Overlay Preferences'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.grid_3x3),
                  title: const Text('Grid Mode'),
                  subtitle: Text(currentGrid.name.toUpperCase()),
                  trailing: const Icon(LucideIcons.chevron_right),
                  onTap: () {
                    ref.read(gridSettingsProvider.notifier).toggleGrid();
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(LucideIcons.circle_dashed),
                  title: const Text('Overlay Opacity'),
                  subtitle: Slider(
                    value: currentOpacity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    label: '${(currentOpacity * 100).toInt()}%',
                    onChanged: (val) {
                      ref.read(overlaySettingsProvider.notifier).setOpacity(val);
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // General Settings Section
          _buildSectionHeader('App & Data'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.rotate_ccw),
                  title: const Text('Re-run Onboarding'),
                  subtitle: const Text('View initial welcome tour'),
                  trailing: const Icon(LucideIcons.chevron_right),
                  onTap: () => context.go('/onboarding'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(LucideIcons.trash_2, color: Colors.red),
                  title: const Text('Clear Saved Favorites & Recents', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final favs = hive.getFavorites();
                    for (var f in favs) {
                      await hive.toggleFavorite(f);
                    }
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Cleared local favorites & history')),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader('About FrameIQ'),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(LucideIcons.info),
                  title: Text('Version'),
                  trailing: Text('1.0.0+1', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(LucideIcons.shield_check),
                  title: Text('Privacy Policy'),
                  subtitle: Text('100% On-Device Photography Coach'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3, // Settings tab
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}