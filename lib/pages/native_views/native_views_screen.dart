import 'package:flutter/material.dart';

import '../../native_views/native_text_view.dart';

class NativeViewsScreen extends StatelessWidget {
  const NativeViewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Android Views'),
      ),
      body: const Center(
        child: SizedBox(
          width: 300,
          height: 150,
          child: NativeTextView(),
        ),
      ),
    );
  }
}