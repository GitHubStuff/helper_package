import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';

class ClockScreen extends StatelessWidget {
  static const String route = '/ClockScreen';

  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Clock'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Modular.to.pop();
        },
      ),
    );
  }

  Widget homeWidget(BuildContext context) {
    final double dimension = MediaQuery.of(context).size.height / 4.0;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClockFace(
              dimension: dimension,
              utcMinuteOffset: -7 * 60,
              backgroundColor: Colors.yellow,
              secondColor: Colors.green,
              faceNumberOffset: 20.0,
              numberStyle: const TextStyle(
                  color: Colors.purple,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ).paddingAll(8.0),
            ClockFace(
              dimension: dimension,
              faceColor: Colors.white,
              backgroundColor: Colors.transparent,
              //secondColor: Colors.black87,
              faceNumberOffset: 20.0,
            ).paddingAll(8.0),
            ClockFace(
              dimension: dimension,
              utcMinuteOffset: 2 * 60,
              faceColor: Colors.white,
              backgroundColor: Colors.transparent,
              secondColor: Colors.red,
              //faceNumberOffset: 12.0,
            ).paddingAll(8.0),
          ],
        ),
      ),
    ).paddingAll(8.0);
  }
}
