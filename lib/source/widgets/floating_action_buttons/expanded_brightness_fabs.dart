import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global.dart';
import '../../palette/palette.dart';
import '../../palette/palette_enum.dart';
import 'expanded_brightness_fab.dart';

List<Widget> buildExpandingActionButtons(
    {required WidgetRef ref,
    String tipAppDark = 'Application Dark',
    String tipAppLight = 'Application Light',
    String tipSystemDark = 'System Dark',
    String tipSystemLight = 'System Light',
    bool showToast = false}) {
  Palette paletteNotifier = ref.watch(paletteProvider.notifier);
  final buttons = <Widget>[
    ExpandedBrightnessFAB(
      icon: PaletteEnum.applicationLight.icon,
      onPressed: () {
        paletteNotifier.setPaletteLightMode();
        if (showToast) _showAlert(tipAppLight);
      },
      tooltip: tipAppLight,
    ),
    ExpandedBrightnessFAB(
      icon: PaletteEnum.applicationDark.icon,
      onPressed: () {
        paletteNotifier.setPaletteDarkMode();
        if (showToast) _showAlert(tipAppDark);
      },
      tooltip: tipAppDark,
    ),
  ];
  final mode = PlatformDispatcher.instance.platformBrightness;
  switch (mode) {
    case Brightness.dark:
      buttons.add(
        ExpandedBrightnessFAB(
          icon: PaletteEnum.systemDark.icon,
          onPressed: () {
            paletteNotifier.setPaletteSystemMode();
            if (showToast) _showAlert(tipSystemDark);
          },
          tooltip: tipSystemDark,
        ),
      );
      break;
    case Brightness.light:
      buttons.add(
        ExpandedBrightnessFAB(
          icon: PaletteEnum.systemLight.icon,
          onPressed: () {
            paletteNotifier.setPaletteSystemMode();
            if (showToast) _showAlert(tipSystemLight);
          },
          tooltip: tipSystemLight,
        ),
      );
      break;
  }
  return buttons;
}

void _showAlert(String content) {
  final snackBar = SnackBar(
    content: Text(content),
    duration: const Duration(milliseconds: 500),
  );
  ScaffoldMessenger.of(Global.context).showSnackBar(snackBar);
}
