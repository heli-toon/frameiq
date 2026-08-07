import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/features/environments/domain/models/environment_model.dart';
import 'package:frameiq/shared/data/mock_data.dart';
import 'package:frameiq/shared/providers/selection_providers.dart';

class EnvironmentSelectionScreen extends ConsumerWidget {
  const EnvironmentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScene = ref.watch(selectedSceneProvider);

    final matchingEnvironments = MockData.environments.where((env) {
      if (selectedScene == null) return true;
      return env.sceneId == selectedScene.id;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedScene != null ? '${selectedScene.title} Environments' : 'Environments'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrow_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: matchingEnvironments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.map_pin, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No environments available for ${selectedScene?.title ?? "this scene"} yet.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Back to Scenes'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: matchingEnvironments.length,
              itemBuilder: (context, index) {
                final env = matchingEnvironments[index];
                return _buildEnvironmentTile(context, ref, env);
              },
            ),
    );
  }

  Widget _buildEnvironmentTile(BuildContext context, WidgetRef ref, EnvironmentModel env) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            env.imageAsset,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          env.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${env.posesCount} Composition Poses available'),
        ),
        trailing: const Icon(LucideIcons.chevron_right),
        onTap: () {
          ref.read(selectedEnvironmentProvider.notifier).state = env;
          context.push('/poses');
        },
      ),
    );
  }
}