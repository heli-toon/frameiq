import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/features/camera/domain/models/overlay_model.dart';
import 'package:frameiq/features/camera/providers/overlay_providers.dart';
import 'package:frameiq/shared/data/mock_data.dart';

class OverlayBrowserScreen extends ConsumerStatefulWidget {
  const OverlayBrowserScreen({super.key});

  @override
  ConsumerState<OverlayBrowserScreen> createState() => _OverlayBrowserScreenState();
}

class _OverlayBrowserScreenState extends ConsumerState<OverlayBrowserScreen> {
  String _searchQuery = '';
  String _selectedDifficulty = 'All';

  @override
  Widget build(BuildContext context) {
    final overlays = MockData.overlays.where((overlay) {
      final matchesSearch = overlay.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (overlay.tips?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      final matchesDiff = _selectedDifficulty == 'All' || overlay.difficulty == _selectedDifficulty;
      return matchesSearch && matchesDiff;
    }).toList();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : const Color(0xFFE2E8F0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Browser'),
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
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                // Super-flat Search Field
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: borderColor,
                      width: 0.8,
                    ),
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.transparent,
                      hintText: 'Search composition overlays...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                      prefixIcon: Icon(
                        LucideIcons.search,
                        size: 18,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Super-flat Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Beginner', 'Intermediate', 'Advanced'].map((diff) {
                      final isSelected = _selectedDifficulty == diff;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDifficulty = diff;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark ? Colors.white : const Color(0xFF0F172A))
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : const Color(0xFFF1F5F9)),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : borderColor,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              diff,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected
                                    ? (isDark ? const Color(0xFF090D16) : Colors.white)
                                    : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Grid of Overlays
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.80,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: overlays.length,
              itemBuilder: (context, index) {
                final overlay = overlays[index];
                return _buildOverlayCard(context, ref, overlay, borderColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayCard(
    BuildContext context,
    WidgetRef ref,
    OverlayModel overlay,
    Color borderColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        ref.read(selectedOverlayProvider.notifier).state = overlay;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFF0F172A), // Dark viewfinder backdrop for overlay silhouette
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  overlay.overlayAsset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overlay.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.zoom_in,
                        size: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${overlay.recommendedZoom}x zoom',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        overlay.difficulty,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
