part of './../services.dart';

class CamerGalleryServiceImp extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<String?> selectFromGallery() async {
    // TODO: implement selectFromGallery
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<List<String>?> selectMultiplePhotohs() {
    // TODO: implement selectMultiplePhotohs
    throw UnimplementedError();
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    return photo.path;
  }
}
