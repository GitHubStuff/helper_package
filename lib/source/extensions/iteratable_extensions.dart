import 'package:flutter/material.dart';

extension ExpandEqually on Iterable<Widget> {
  /// Reduce use of Expanded() by 'pre-wrapp' the items in Widget array with Expanded
  /// ```dart
  ///
  /*
    Row(
       mainAxisSize: MainAxisSize.max,
       children: [
          Container(
                height: 200,
                color: Colors.yellow,
              ),
              Container(
                height: 200,
                color: Colors.blue,
              ),
            ].expandedEqually().toList(),
          )
  */

  Iterable<Widget> expandedEqually() => map(
        (w) => Expanded(
          flex: 1,
          child: w,
        ),
      );
}
