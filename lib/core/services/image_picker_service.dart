import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ImagePickerService {
  Future<String?> pick({required bool camera});
}

class ImagePickerServiceImpl implements ImagePickerService {
  final _picker = ImagePicker();

  @override
  Future<String?> pick({required bool camera}) async {
    final file = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    return file?.path;
  }
}

final imagePickerServiceProvider =
    Provider<ImagePickerService>((ref) => ImagePickerServiceImpl());
