import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xbsdating/authenticationScreen/login_screen.dart';
import 'package:xbsdating/homeScreen/home_screen.dart';

import "package:xbsdating/models/person.dart" as personModel;

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;
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

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference referenceStorage = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;
    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();
    return downloadUrlOfImage;
  }

  //Create user account
  createNewUserAccount(
    File imageProfile,
    String email,
    String password,
    String name,
    String age,
    String gender,
    String phoneNo,
    String city,
    String country,
    String profileHeading,
    String lookingForInaPartner,

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
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      //3. save user info to firestore database
      personModel.Person personInstance = personModel.Person(
        //Personal info
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        name: name,
        email: email,
        password: password,
        age: int.parse(age),
        gender: gender.toLowerCase(),
        phoneNo: phoneNo,
        city: city,
        country: country,
        profileHeading: profileHeading,
        lookingForInaPartner: lookingForInaPartner,
        publishedDateTime: DateTime.now().microsecondsSinceEpoch,

        //Appearance
        height: height,
        weight: weight,
        bodyType: bodyType,

        //life style
        drink: drink,
        smoke: smoke,
        martialStatus: martialStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        profession: profession,
        employmentStatus: employmentStatus,
        income: income,
        livingSituatin: livingSituatin,
        willingToRelocate: willingToRelocate,
        relationshipYouAreLookingFor: relationshipYouAreLookingFor,

        //Background values
        nationality: nationality,
        education: education,
        languageSpoken: languageSpoken,
        religion: religion,
        ethnicity: ethnicity,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());
      Get.snackbar(
          "Account Created", "Congratulation, your account has been created");
      //Routing to home screen
      Get.to(() => const HomeScreen());
    } catch (errorMsg) {
      Get.snackbar("Account Creation Unsuccessful", "Error occured: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUser,
        password: passwordUser,
      );
      Get.snackbar(
        "Logged-in Successful",
        "You're logged-in successfully.",
      );

      Get.to(() => const HomeScreen());
    } catch (errorMsg) {
      Get.snackbar(
        "Login Unsuccessful",
        "Error occured : $errorMsg",
      );
    }
  }

  //user loggedin
  checkIfUserIsLoggedIn(User? currentUser) {
    if (currentUser == null) {
      Get.to(() => const LoginScreen());
    } else {
      Get.to(() => const HomeScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
