// Adds helpers for afterFirstLayout, didChangePlatformBrightness,
// didChangeAppLifecycleState
import 'package:flutter/material.dart';

abstract class ObservingStatefulWidget<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    instance.addPostFrameCallback((_) => afterFirstLayout(context));
    instance.addObserver(this);
  }

  void afterFirstLayout(BuildContext context) {}

  void reportTextScaleFactor(double? textScaleFactor) {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
