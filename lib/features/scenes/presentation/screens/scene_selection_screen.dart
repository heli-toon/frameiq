import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/features/scenes/domain/models/scene_model.dart';
import 'package:frameiq/shared/data/mock_data.dart';
import 'package:frameiq/shared/providers/selection_providers.dart';

class SceneSelectionScreen extends ConsumerStatefulWidget {
  const SceneSelectionScreen({super.key});

  @override
  ConsumerState<SceneSelectionScreen> createState() => _SceneSelectionScreenState();
}

class _SceneSelectionScreenState extends ConsumerState<SceneSelectionScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredScenes = MockData.scenes.where((scene) {
      return scene.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          scene.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Scene'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search scenes (Beach, Cafe, Street)...',
                prefixIcon: const Icon(LucideIcons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Scene Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredScenes.length,
              itemBuilder: (context, index) {
                final scene = filteredScenes[index];
                return _buildSceneCard(context, ref, scene);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSceneCard(BuildContext context, WidgetRef ref, SceneModel scene) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedSceneProvider.notifier).state = scene;
        context.push('/environments');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    scene.imageAsset,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${scene.environmentsCount} Env',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scene.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scene.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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