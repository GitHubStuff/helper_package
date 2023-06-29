/// Creates a FAB button that when pressed will show all the [children] widgets in an arc
/// around the FAB button. This enables the FAB to have multiple children/actions
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'expanded_brightness_fabs.dart';

const _animationDuration = Duration(milliseconds: 250);
const _boxSide = 56.0;

@immutable
class ExpandableFAB extends StatefulWidget {
  const ExpandableFAB({
    super.key,
    required this.children,
    this.initialOpen = false,
    this.distanceFromFAB = 100.0,
    this.openIcon,
    this.closeIcon,
  });

  factory ExpandableFAB.ofModes({
    required WidgetRef ref,
    required bool showToast,
  }) =>
      ExpandableFAB(children: buildExpandingActionButtons(ref: ref, showToast: showToast));

  final bool initialOpen;
  final double distanceFromFAB;

  /// Widget array, typically circular buttons that are displayed in an arc around the FAB
  final List<Widget> children;
  final Icon? openIcon;
  final Icon? closeIcon;

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late bool _open;
  late Icon _openIcon;
  late Icon _closeIcon;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen;
    _openIcon = widget.openIcon ?? const Icon(Icons.open_in_full_sharp);
    _closeIcon = widget.closeIcon ?? const Icon(Icons.close_fullscreen_outlined);

    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: _animationDuration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: _boxSide,
      height: _boxSide,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _closeIcon,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distanceFromFAB,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: _animationDuration,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: _animationDuration,
          child: FloatingActionButton(
            onPressed: _toggle,
            child: _openIcon,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
