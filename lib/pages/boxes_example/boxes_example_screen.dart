import 'package:flutter/material.dart';
import '../../shared/theme/theme.dart';
import '../../shared/theme/colors.dart';
class BoxesExampleScreen extends StatelessWidget {
  const BoxesExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Boxes'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // LimitedBox
          _SectionTitle(title: 'LimitedBox'),
          SizedBox(height: 8),
          _Description(
            text:
                'Limits max size only when the parent gives unbounded constraints.',
          ),
          SizedBox(height: 12),
          _LimitedBoxExample(),
          SizedBox(height: 24),

          // ConstrainedBox
          _SectionTitle(title: 'ConstrainedBox'),
          SizedBox(height: 8),
          _Description(
            text: 'Applies min and max constraints to its child.',
          ),
          SizedBox(height: 12),
          _ConstrainedBoxExample(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

// LimitedBox
class _LimitedBoxExample extends StatelessWidget {
  const _LimitedBoxExample();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inside a horizontal ListView (unbounded width):',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _LimitedColoredBox(color: Color(AppColors.primary)),
                  SizedBox(width: 12),
                  _LimitedColoredBox(color: Color(AppColors.clearBlue)),
                  SizedBox(width: 12),
                  _LimitedColoredBox(color: Color(AppColors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LimitedColoredBox extends StatelessWidget {
  final Color color;

  const _LimitedColoredBox({required this.color});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 120,
      maxHeight: 80,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: const Text(
          'max 120',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ConstrainedBox
class _ConstrainedBoxExample extends StatelessWidget {
  const _ConstrainedBoxExample();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 200,
                minHeight: 60,
                maxHeight: 100,
              ),
              child: Container(
                width: double.infinity,
                color: const Color(AppColors.primary),
                alignment: Alignment.center,
                child: const Text(
                  'min 100×60\nmax 200×100',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 160,
                height: 48,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Fixed 160×48'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}