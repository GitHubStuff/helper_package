import 'package:flutter/material.dart';

enum PaletteEnum {
  applicationDark,
  applicationLight,
  systemDark,
  systemLight;

  Icon get icon {
    switch (this) {
      case PaletteEnum.applicationDark:
        return const Icon(Icons.lightbulb_outline);
      case PaletteEnum.applicationLight:
        return const Icon(Icons.lightbulb);
      case PaletteEnum.systemDark:
        return const Icon(Icons.dark_mode_outlined);
      case PaletteEnum.systemLight:
        return const Icon(Icons.light_mode_sharp);
    }
  }
}
