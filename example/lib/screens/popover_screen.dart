// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:helper_package/helper_package.dart';

import '../gen/assets.gen.dart';

class PopoverScreen extends StatelessWidget {
  static const String route = '/PopoverScreen';

  const PopoverScreen({super.key});

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
      title: const Text('Popover'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Modular.to.pop();
        },
      ),
    );
  }

  Widget homeWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.ltmm1024x1024.image(),
            ),
          ),
          const Button(
            caption: 'Set Date',
            pickerType: PickerType.date,
          ).paddingAll(8.0),
          const Button(
            caption: 'Set Time',
            pickerType: PickerType.time,
          ).paddingAll(8.0),
          const Button(
            caption: 'Both',
            pickerType: PickerType.dateTime,
          ).paddingAll(8.0),
        ],
      ),
    ).paddingAll(8.0);
  }
}

class Button extends StatefulWidget {
  const Button(
      {super.key,
      required this.caption,
      this.pickerType = PickerType.dateTime});
  final String caption;
  final PickerType pickerType;
  @override
  State<Button> createState() => _Button();
}

class _Button extends State<Button> {
  late String caption;

  @override
  void initState() {
    super.initState();
    caption = widget.caption;
  }

  @override
  Widget build(BuildContext context) {
    return PopoverDateTimePicker(
      onSet: (dateTime) {
        debugPrint('onSet: $dateTime');
        setState(() {
          switch (widget.pickerType) {
            case PickerType.date:
              caption = dateTime.shortDate();
              break;
            case PickerType.time:
              caption = dateTime.shortTime();
              break;
            case PickerType.dateTime:
              caption = '${dateTime.shortDate()} ${dateTime.shortTime()}';
              break;
          }
        });
      },
      onDismiss: () {
        debugPrint('Dismissed');
      },
      showDate: true,
      showTime: true,
      includeSeconds: false,
      child: target(caption),
    );
  }

  Widget target(String caption) {
    return Container(
        width: 200,
        height: 60,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 217, 233),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Center(child: Text(caption)));
  }
}
