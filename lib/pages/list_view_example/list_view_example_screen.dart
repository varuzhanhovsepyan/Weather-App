import 'package:flutter/material.dart';
import '../../shared/theme/colors.dart';

class ListViewExampleScreen extends StatelessWidget {
  const ListViewExampleScreen({super.key});

  static const _items = [
    'Moscow',
    'London',
    'New York',
    'Paris',
    'Tokyo',
    'Berlin',
    'Rome',
    'Madrid',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('ListView'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle(title: 'ListView.builder'),
          SizedBox(height: 8),
          _BuilderExample(items: _items),
          SizedBox(height: 24),

          _SectionTitle(title: 'ListView.separated'),
          SizedBox(height: 8),
          _SeparatedExample(items: _items),
          SizedBox(height: 24),

          _CustomExample(items: _items),
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

class _CityTile extends StatelessWidget {
  final String city;
  final int index;

  const _CityTile({
    required this.city,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(AppColors.primary),
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      title: Text(
        city,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        'City',
        style: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ListView.builder
class _BuilderExample extends StatelessWidget {
  final List<String> items;

  const _BuilderExample({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _CityTile(
              city: items[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

// ListView.separated
class _SeparatedExample extends StatelessWidget {
  final List<String> items;

  const _SeparatedExample({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _CityTile(
              city: items[index],
              index: index,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              indent: 72,
              color: Theme.of(context).dividerColor,
            );
          },
        ),
      ),
    );
  }
}

// ListView.custom + SliverChildBuilderDelegate = ListView.builder
class _CustomExample extends StatelessWidget {
  final List<String> items;

  const _CustomExample({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              return _CityTile(
                city: items[index],
                index: index,
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }
}