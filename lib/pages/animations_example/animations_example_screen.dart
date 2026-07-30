import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../shared/theme/colors.dart';
class AnimationsExampleScreen extends StatelessWidget {
  const AnimationsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Animations'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle(title: 'Drawing animations'),
          SizedBox(height: 8),
          _DrawingAnimationExample(),
          SizedBox(height: 24),

          _SectionTitle(title: 'AnimationController'),
          SizedBox(height: 8),
          _AnimationControllerExample(),
          SizedBox(height: 24),

          _SectionTitle(title: 'Implicit animations'),
          SizedBox(height: 8),
          _ImplicitAnimationExample(),
          SizedBox(height: 24),

          _SectionTitle(title: 'Explicit animations'),
          SizedBox(height: 8),
          _ExplicitAnimationExample(),
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

class _ExampleCard extends StatelessWidget {
  final Widget child;

  const _ExampleCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: child),
      ),
    );
  }
}

// Drawing animations
class _DrawingAnimationExample extends StatefulWidget {
  const _DrawingAnimationExample();

  @override
  State<_DrawingAnimationExample> createState() =>
      _DrawingAnimationExampleState();
}

class _DrawingAnimationExampleState extends State<_DrawingAnimationExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ExampleCard(
      child: SizedBox(
        width: 120,
        height: 120,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _ArcPainter(progress: _controller.value),
            );
          },
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final paint = Paint()
      ..color = const Color(AppColors.primary)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// AnimationController
class _AnimationControllerExample extends StatefulWidget {
  const _AnimationControllerExample();

  @override
  State<_AnimationControllerExample> createState() =>
      _AnimationControllerExampleState();
}

class _AnimationControllerExampleState extends State<_AnimationControllerExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _size;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _size = Tween<double>(begin: 40, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ExampleCard(
      child: AnimatedBuilder(
        animation: _size,
        builder: (context, child) {
          return Container(
            width: _size.value,
            height: _size.value,
            decoration: const BoxDecoration(
              color: Color(AppColors.primary),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

// Implicit animations
class _ImplicitAnimationExample extends StatefulWidget {
  const _ImplicitAnimationExample();

  @override
  State<_ImplicitAnimationExample> createState() =>
      _ImplicitAnimationExampleState();
}

class _ImplicitAnimationExampleState extends State<_ImplicitAnimationExample> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return _ExampleCard(
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: _expanded ? 160 : 80,
          height: 80,
          decoration: BoxDecoration(
            color: _expanded
                ? const Color(AppColors.clearBlue)
                : const Color(AppColors.primary),
            borderRadius: BorderRadius.circular(_expanded ? 16 : 40),
          ),
          alignment: Alignment.center,
          child: Text(
            _expanded ? 'Tap me' : 'Tap',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Explicit animations
class _ExplicitAnimationExample extends StatefulWidget {
  const _ExplicitAnimationExample();

  @override
  State<_ExplicitAnimationExample> createState() =>
      _ExplicitAnimationExampleState();
}

class _ExplicitAnimationExampleState extends State<_ExplicitAnimationExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ExampleCard(
      child: RotationTransition(
        turns: _controller,
        child: const Icon(
          Icons.wb_sunny,
          size: 64,
          color: Color(AppColors.primary),
        ),
      ),
    );
  }
}