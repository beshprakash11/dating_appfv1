import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  String? userID;
  UserDetailsScreen({
    super.key,
    this.userID,
  });

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  //personal info
  String name = "";
  String age = "";
  String phoneNo = "";
  String city = "";
  String country = "";
  String profileHeading = "";
  String lookingForInaPartner = "";

  //Appearance
  String height = "";
  String weight = "";
  String bodyType = "";

  //Life style
  String drink = "";
  String smoke = "";
  String martialStatus = "";
  String haveChildren = "";
  String noOfChildren = "";
  String profession = "";
  String employmentStatus = "";
  String income = "";
  String livingSituatin = "";
  String willingToRelocate = "";
  String relationshipYouAreLookingFor = "";

  //Slider images
  String urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-eb8d5.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=83b4c24a-2204-4e85-ad1c-8d82308c76cc";
  String urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-eb8d5.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=83b4c24a-2204-4e85-ad1c-8d82308c76cc";
  String urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-eb8d5.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=83b4c24a-2204-4e85-ad1c-8d82308c76cc";
  String urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-eb8d5.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=83b4c24a-2204-4e85-ad1c-8d82308c76cc";
  String urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-eb8d5.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=83b4c24a-2204-4e85-ad1c-8d82308c76cc";

  retrieveUserInfo() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "User Details Screen",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
