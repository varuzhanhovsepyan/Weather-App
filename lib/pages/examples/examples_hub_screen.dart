import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../animations_example/animations_example_screen.dart';
import '../boxes_example/boxes_example_screen.dart';
import '../list_view_example/list_view_example_screen.dart';
import '../notifications/notifications_screen.dart';
import '../native_views/native_views_screen.dart';
import '../native_views/hybrid_composition_screen.dart';

class ExamplesHubScreen extends StatelessWidget {
  const ExamplesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Examples'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _ExampleTile(
            title: 'ListView',
            subtitle: 'builder · separated · custom',
            icon: Icons.list_alt,
            screen: ListViewExampleScreen(),
          ),
          const SizedBox(height: 12),
          const _ExampleTile(
            title: 'Animations',
            subtitle: 'drawing · controller · implicit · explicit',
            icon: Icons.animation,
            screen: AnimationsExampleScreen(),
          ),
          const SizedBox(height: 12),
          const _ExampleTile(
            title: 'Boxes',
            subtitle: 'LimitedBox · ConstrainedBox',
            icon: Icons.crop_square,
            screen: BoxesExampleScreen(),
          ),
          const SizedBox(height: 12),
          _ExampleTile(
            title: l10n.pushNotifications,
            subtitle: l10n.fcmToken,
            icon: Icons.notifications_outlined,
            screen: const NotificationsScreen(),
          ),
          const SizedBox(height: 12),
          _ExampleTile(
            title: 'Native Views',
            subtitle: 'Texture Layer',
            icon: Icons.android,
            screen: NativeViewsScreen(),
          ),
          const SizedBox(height: 12),
          _ExampleTile(
            title: 'Hybrid Composition',
            subtitle: 'Hybrid Composition',
            icon: Icons.layers,
            screen: HybridCompositionScreen(),
          ),
        ],
      ),
    );
  }
}

class _ExampleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;

  const _ExampleTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}