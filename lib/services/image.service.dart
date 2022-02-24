import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:placer/utils/uuid.utils.dart';

// TODO: cached_network_image
class ImageService {
  static Future<String?> uploadImageGallery(String placeUuid) async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

    print(file?.path);
    return uploadFileToFirebase(placeUuid, file!);
  }

  static Future<String?> uploadFileToFirebase(String placeUuid, XFile file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String imageUuid = generateUuid();
    Reference ref = storage.ref().child('places/$placeUuid/$imageUuid');

    File imageFile = File(file.path);
    String? mimeType = mime(file.path) == null ? 'image/png' : mime(file.path);

    print('mimeType: $mimeType');
    print('file.path: ${file.path}');

    String? imageUrl = null;

    try {
      TaskSnapshot taskSnapshot = kIsWeb
          ? await ref.putData(await file.readAsBytes(), SettableMetadata(contentType: mimeType))
          : await ref.putFile(imageFile, SettableMetadata(contentType: mimeType));
      imageUrl = await ref.getDownloadURL();
    } on FirebaseException catch (error) {
      print(error);
      imageUrl = null;
      return null;
    }

    return imageUrl;
  }

// static Future<Widget> _getImage(BuildContext context, String imageName) async {
//   Image image;
//   await FirebaseStorage.loadImage(context, imageName).then((value) {
//     image = Image.network(value.toString(), fit: BoxFit.scaleDown);
//   });
//   return image;
// }
}
