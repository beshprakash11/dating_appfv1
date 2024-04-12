import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();
  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFileFormGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully picked your profile image.");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromPhoneCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully capture your profile image.");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  //Create user account
  createNewUserAccount(
    String imageProfile,
    String email,
    String password,
    String name,
    String age,
    String phoneNo,
    String city,
    String country,
    String profileHeading,
    String lookingForInaPartner,
    int publishedDateTime,

    //Appearance
    String height,
    String weight,
    String bodyType,

    //Life style
    String drink,
    String smoke,
    String martialStatus,
    String haveChildren,
    String noOfChildren,
    String profession,
    String employmentStatus,
    String income,
    String livingSituatin,
    String willingToRelocate,
    String relationshipYouAreLookingFor,

    //Background - Cultureal values
    String nationality,
    String education,
    String languageSpoken,
    String religion,
    String ethnicity,
  ) async {
    try {
      //1. authenticate user and create User with Email and Password
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //2. upload image to storage
      await uploadImageToStorage(imageProfile);
    } catch (errorMsg) {
      Get.snackbar("Account Creation Unsuccessful", "Error occured: $errorMsg");
    }
  }

  uploadImageToStorage(String imageProfile) {}
}
