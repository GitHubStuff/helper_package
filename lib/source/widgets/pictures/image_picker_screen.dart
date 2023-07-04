import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'image_picker_widget.dart';

class PictureScreen extends StatelessWidget {
  static const String route = "/PictureScreen";
  const PictureScreen({
    super.key,
    this.title = "Get a picture",
    this.cameraPrompt = "Use Camera",
    this.libraryPrompt = "Use Library",
    this.selectPrompt = "Select",
    this.pictureName,
  });
  final String title;
  final String cameraPrompt;
  final String libraryPrompt;
  final String selectPrompt;
  final String? pictureName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: SafeArea(
          child: ImagePickerWidget(
        cameraPrompt: cameraPrompt,
        libraryPrompt: libraryPrompt,
        selectPrompt: selectPrompt,
        pictureName: pictureName,
      )),
      floatingActionButton: null,
    );
  }
}
