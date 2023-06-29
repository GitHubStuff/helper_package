// ignore_for_file: sort_child_properties_last

import 'package:example/screens/popover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';

import '../gen/assets.gen.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.ltmm1024x1024.image(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Modular.to.pushNamed(PopoverScreen.route);
            },
            child: const Text('Show Popover'),
          ).paddingAll(8.0),
        ],
      ),
    );
  }
}
