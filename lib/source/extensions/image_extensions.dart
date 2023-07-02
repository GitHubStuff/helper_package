import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'num_extensions.dart';

/// Helpers on Image
///  * leftRotation
///  * rightRotation
///  * upsideDownRotation
///  * rotate
///  * asBytes
extension ImageExtension on Image {
  Widget get leftRotation => rotate(percentage: -25.pct);
  Widget get rightRotation => rotate(percentage: 25.pct);
  Widget get upsideDownRotation => rotate(percentage: 50.pct);
  Widget rotate({required double percentage}) => RotationTransition(
        turns: AlwaysStoppedAnimation(percentage),
        child: this,
      );

  Future<Uint8List?> asBytes() async {
    final _WidgetPngController controller = _WidgetPngController();
    _WidgetPntConverter(controller: controller, child: this);
    return await controller.capture();
  }
}

class _WidgetPngController {
  GlobalKey containerKey = GlobalKey();

  /// to capture widget to image by GlobalKey in RenderRepaintBoundary
  Future<Uint8List?> capture() async {
    try {
      /// boundary widget by GlobalKey
      RenderRepaintBoundary? boundary = containerKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      /// convert boundary to image
      final image = await boundary!.toImage(pixelRatio: 6);

      /// set ImageByteFormat
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      rethrow;
    }
  }
}

class _WidgetPntConverter extends StatelessWidget {
  final Widget? child;
  final _WidgetPngController controller;

  const _WidgetPntConverter({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// to capture widget to image by GlobalKey in RepaintBoundary
    return RepaintBoundary(
      key: controller.containerKey,
      child: child,
    );
  }
}
