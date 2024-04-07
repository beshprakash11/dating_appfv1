import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();
  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;

  pickImageFileFormGallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
