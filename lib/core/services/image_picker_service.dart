import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ImagePickerService {
  Future<String?> pick({required bool camera});
}

class ImagePickerServiceImpl implements ImagePickerService {
  final _picker = ImagePicker();

  @override
  Future<String?> pick({required bool camera}) async {
    try {
      final file = await _picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );

      return file?.path;
    } on PlatformException catch (e) {
      debugPrint('Camera error: ${e.code} - ${e.message}');
      return null;
    }
  }
}

final imagePickerServiceProvider = Provider<ImagePickerService>(
  (ref) => ImagePickerServiceImpl(),
);
