import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

class HybridCompositionScreen extends StatelessWidget {
  const HybridCompositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const viewType = 'native-text-view';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hybrid Composition'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 150,
          child: PlatformViewLink(
            viewType: viewType,
            surfaceFactory: (
              BuildContext context,
              PlatformViewController controller,
            ) {
              return AndroidViewSurface(
                controller: controller as AndroidViewController,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              );
            },
            onCreatePlatformView: (PlatformViewCreationParams params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: viewType,
                layoutDirection: TextDirection.ltr,
                creationParams: null,
                creationParamsCodec: const StandardMessageCodec(),
              )
                ..addOnPlatformViewCreatedListener(
                  params.onPlatformViewCreated,
                )
                ..create();
            },
          ),
        ),
      ),
    );
  }
}