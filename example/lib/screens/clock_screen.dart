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
            SizedBox.square(
              dimension: dimension,
              child: const ClockFace(
                utcOffset: -7,
                faceColor: Colors.purple,
                backgroundColor: Colors.transparent,
                secondColor: Colors.white70,
                faceNumberOffset: 20.0,
                tickColor: Colors.white,
                hourColor: Colors.yellow,
                minuteColor: Colors.yellow,
                numberStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ).paddingAll(8.0),
            SizedBox.square(
              dimension: dimension,
              child: const ClockFace(
                utcOffset: -4,
                faceColor: Colors.white,
                backgroundColor: Colors.transparent,
                secondColor: Colors.red,
                faceNumberOffset: 20.0,
              ),
            ).paddingAll(8.0),
            SizedBox.square(
              dimension: dimension,
              child: const ClockFace(
                utcOffset: 2,
                faceColor: Colors.white,
                backgroundColor: Colors.transparent,
                secondColor: Colors.red,
                faceNumberOffset: 20.0,
              ),
            ).paddingAll(8.0),
          ],
        ),
      ),
    ).paddingAll(8.0);
  }
}
