import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<File?> pickImage(bool profilepic, int x, int y) async {
  final pickedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 1,
  );

  if (pickedImage == null) {
    return null;
  }

  final croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedImage.path,
    aspectRatio: CropAspectRatio(ratioX: x.toDouble(), ratioY: y.toDouble()),
    compressQuality: 10,
    compressFormat: ImageCompressFormat.jpg,
  );

  if (croppedFile == null) {
    return null;
  }

  return File(croppedFile.path);
}

String formatDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
