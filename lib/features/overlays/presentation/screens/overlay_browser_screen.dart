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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Browser'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search composition overlays...',
                    prefixIcon: const Icon(LucideIcons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Beginner', 'Intermediate', 'Advanced'].map((diff) {
                      final isSelected = _selectedDifficulty == diff;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(diff),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = diff;
                            });
                          },
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: overlays.length,
              itemBuilder: (context, index) {
                final overlay = overlays[index];
                return _buildOverlayCard(context, ref, overlay);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayCard(BuildContext context, WidgetRef ref, OverlayModel overlay) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedOverlayProvider.notifier).state = overlay;
        context.go('/camera');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardTheme.color,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.black87,
                alignment: Alignment.center,
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(LucideIcons.zoom_in, size: 12, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 4),
                      Text('${overlay.recommendedZoom}x zoom', style: const TextStyle(fontSize: 11)),
                      const Spacer(),
                      Text(overlay.difficulty, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
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