import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'palette_enum.dart';

part 'palette.g.dart';
part 'palette_theme.dart';

@riverpod
class Palette extends _$Palette {
  static Future<void> setup() async => await _PaletteTheme.setup();

  static PaletteEnum get brightness {
    switch (_PaletteTheme.mode) {
      case ThemeMode.dark:
        return PaletteEnum.applicationDark;
      case ThemeMode.light:
        return PaletteEnum.applicationLight;
      case ThemeMode.system:
        final mode = PlatformDispatcher.instance.platformBrightness;
        switch (mode) {
          case Brightness.dark:
            return PaletteEnum.systemDark;
          case Brightness.light:
            return PaletteEnum.systemLight;
        }
    }
  }

  static Color color({required Color dark, required Color light}) {
    switch (brightness) {
      case PaletteEnum.applicationDark:
      case PaletteEnum.systemDark:
        return dark;
      case PaletteEnum.applicationLight:
      case PaletteEnum.systemLight:
        return light;
    }
  }

  @override
  ThemeMode build() => _PaletteTheme.mode;
  void setPaletteDarkMode() => _newPaletteMode(ThemeMode.dark);
  void setPaletteLightMode() => _newPaletteMode(ThemeMode.light);
  void setPaletteSystemMode() => _newPaletteMode(ThemeMode.system);

  void _newPaletteMode(ThemeMode newMode) {
    _PaletteTheme.mode = newMode;
    state = newMode;
  }
}
