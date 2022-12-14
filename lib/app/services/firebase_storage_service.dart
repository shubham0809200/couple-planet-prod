import 'dart:io';

import 'package:couple_planet/app/services/firebase_auth_services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:firebase_storage/firebase_storage.dart' as storage;

class FirebaseStorageService {
  final ImagePicker _picker = ImagePicker();
  File? file;

  Future<File?> pickImage(
      {required ImageSource source, double? xRatio, double? yRatio}) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);

    // var file = await ImageCropper().cropImage(
    //   sourcePath: pickedFile.path,
    //   aspectRatio: CropAspectRatio(ratioX: xRatio ?? 1, ratioY: yRatio ?? 1),
    // );
    // if (file == null) {
    //   return null;
    // }

    // file = await compressImagePath(file.path, 35);
    // return file;
  }

  Future<File> compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future<String> uploadUserImage(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(FirebaseAuthService().user.uid);

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    return fileUrl;
  }
}
