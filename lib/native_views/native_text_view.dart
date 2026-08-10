import 'package:flutter/material.dart';

class NativeTextView extends StatelessWidget {
  const NativeTextView({super.key});

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'native-text-view',
    );
  }
}