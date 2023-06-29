/// This is suitable/best icon for FAB buttons used by [expandable_brightness_fabs], this widget is
/// provided to simplify created buttons used by [expandable_brightness_fabs]
import 'package:flutter/material.dart';

@immutable
class ExpandedBrightnessFAB extends StatelessWidget {
  const ExpandedBrightnessFAB({
    super.key,
    this.onPressed,
    required this.icon,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
        tooltip: tooltip,
      ),
    );
  }
}
