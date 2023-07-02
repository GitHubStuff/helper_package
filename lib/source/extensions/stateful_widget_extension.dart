import 'package:flutter/material.dart';

/// Adds helpers:
///  afterFirstLayout,
///  didChangeAppLifecycleState
///  didChangePlatformBrightness,

abstract class ObservingStatefulWidget<T extends StatefulWidget>
    extends State<T> with WidgetsBindingObserver {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    instance.addPostFrameCallback((_) => afterFirstLayout(context));
    instance.addObserver(this);
  }

  void afterFirstLayout(BuildContext context) {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void didChangePlatformBrightness() {}

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
