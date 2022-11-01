import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class HelperImagePicker {
  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();

  Future<void> onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 100,
      );

      _setImageFileListFromFile(pickedFile);
      print(_imageFileList);
    } catch (e) {
      _pickImageError = e;
    }
    ;
  }
}
