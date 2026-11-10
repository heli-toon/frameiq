import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/services/hive_service.dart';
import 'package:frameiq/core/widgets/glass_nav_bar.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : const Color(0xFFE2E8F0);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          // Camera Settings Section
          _buildSectionHeader('Camera & Overlay Preferences'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 0.8),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.grid_3x3, size: 20),
                  title: const Text('Grid Mode', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(
                    currentGrid == GridType.none
                        ? 'Disabled'
                        : currentGrid == GridType.ruleOfThirds
                            ? 'Rule of Thirds'
                            : 'Golden Ratio',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                  trailing: Icon(
                    LucideIcons.chevron_right,
                    size: 18,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                  onTap: () {
                    ref.read(gridSettingsProvider.notifier).toggleGrid();
                  },
                ),
                Divider(color: borderColor, height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.blend, size: 20),
                  title: const Text('Default Overlay Opacity', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    ),
                    child: Slider(
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
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // General Settings Section
          _buildSectionHeader('App & Data'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 0.8),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.rotate_ccw, size: 20),
                  title: const Text('Re-run Onboarding', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(
                    'Review visual composition primer',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                  trailing: Icon(
                    LucideIcons.chevron_right,
                    size: 18,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                  onTap: () => context.go('/onboarding'),
                ),
                Divider(color: borderColor, height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.trash_2, size: 20, color: Color(0xFFEF4444)),
                  title: const Text(
                    'Clear Favorites & History',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
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
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 0.8),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.info, size: 20),
                  title: const Text('Version', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  trailing: Text(
                    '1.0.0+1',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ),
                Divider(color: borderColor, height: 1),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  leading: const Icon(LucideIcons.shield_check, size: 20),
                  title: const Text('Privacy Standard', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(
                    '100% On-Device Photography Coach',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlassFloatingNavBar(
        selectedIndex: 3, // Settings tab
        onItemSelected: (index) {
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF94A3B8)
              : const Color(0xFF64748B),
        ),
      ),
    );
  }
}
