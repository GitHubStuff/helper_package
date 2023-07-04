import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/date_time_extensions.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.cameraPrompt,
    required this.libraryPrompt,
    required this.selectPrompt,
    required this.pictureName,
  });
  final String cameraPrompt;
  final String libraryPrompt;
  final String selectPrompt;
  final String? pictureName;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isImagePicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () => _getImageFromCamera(),
                      child: const Icon(Icons.camera),
                    ),
                    const SizedBox(height: 10), // add some spacing
                    Text(widget.cameraPrompt),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () => _getImageFromGallery(),
                      child: const Icon(Icons.photo_library),
                    ),
                    const SizedBox(height: 10), // add some spacing
                    Text(widget.libraryPrompt),
                  ],
                ),
              ],
            ),
          ),
          if (_isImagePicked)
            Expanded(
              flex: 2,
              child: Image.file(File(_image!.path)),
            ),
          if (_isImagePicked)
            TextButton(
              onPressed: () => _saveImage(),
              child: Text(widget.selectPrompt),
            ),
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _isImagePicked = true;
    });
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _isImagePicked = true;
    });
  }

  Future<void> _saveImage() async {
    String createUniquePhotoName() {
      const Uuid uuid = Uuid();
      return "${DateTimeItem.uniqueDateTime()}${uuid.v4()}"
          .replaceAll(' ', '')
          .replaceAll('-', '')
          .replaceAll(':', '')
          .replaceAll('.', '');
    }

    final fileName = (widget.pictureName ?? "${createUniquePhotoName()}.jpg");
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final XFile? nImage = await FlutterImageCompress.compressAndGetFile(
      _image!.path,
      "$path/$fileName",
      quality: 100,
    );
    final String imagePath = nImage?.path ?? "";
    Modular.to.pop<String>(imagePath);
  }
}
