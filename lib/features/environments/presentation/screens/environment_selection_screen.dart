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

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : const Color(0xFFE2E8F0);

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
                  Icon(
                    LucideIcons.map_pin,
                    size: 40,
                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No environments available for ${selectedScene?.title ?? "this scene"} yet.',
                    style: TextStyle(
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
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
                return _buildEnvironmentTile(context, ref, env, borderColor);
              },
            ),
    );
  }

  Widget _buildEnvironmentTile(
    BuildContext context,
    WidgetRef ref,
    EnvironmentModel env,
    Color borderColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).cardTheme.color,
        border: Border.all(
          color: borderColor,
          width: 0.8,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            env.imageAsset,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          env.title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${env.posesCount} Composition Poses available',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ),
        trailing: Icon(
          LucideIcons.chevron_right,
          size: 18,
          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
        ),
        onTap: () {
          ref.read(selectedEnvironmentProvider.notifier).state = env;
          context.push('/poses');
        },
      ),
    );
  }
}
