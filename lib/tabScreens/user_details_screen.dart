import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_appfv1/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserDetailsScreen extends StatefulWidget {
  String? userID;
  UserDetailsScreen({
    super.key,
    this.userID,
  });

  @override
  // ignore: library_private_types_in_public_api
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

  //Background - Cultureal values
  String nationality = "";
  String education = "";
  String languageSpoken = "";
  String religion = "";
  String ethnicity = "";

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
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }
        setState(() {
          //personal info
          name = snapshot.data()!["name"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profileHeading = snapshot.data()!["profileHeading"];
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];

          //Appearance
          height = snapshot.data()!["height"];
          weight = snapshot.data()!["weight"];
          bodyType = snapshot.data()!["bodyType"];

          //Life style
          drink = snapshot.data()!["drink"];
          smoke = snapshot.data()!["smoke"];
          martialStatus = snapshot.data()!["martialStatus"];
          haveChildren = snapshot.data()!["haveChildren"];
          noOfChildren = snapshot.data()!["noOfChildren"];
          profession = snapshot.data()!["profession"];
          employmentStatus = snapshot.data()!["employmentStatus"];
          income = snapshot.data()!["income"];
          livingSituatin = snapshot.data()!["livingSituatin"];
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];

          //Background - Cultureal values
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethnicity = snapshot.data()!["ethnicity"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserInfo();
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
        //automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
        leading: widget.userID != currentUserID
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ),
              )
            : Container(),
        actions: [
          widget.userID == currentUserID
              ? Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              //image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Colors.black.withOpacity(0.3),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.green,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(
                        urlImage1,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage2,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage3,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage4,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage4,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              //end of image slider

              const SizedBox(
                height: 10,
              ),

              //start personal info
              const SizedBox(
                height: 30,
              ),
              _buildMainTitle("Personal Info:"),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    //Personal info
                    //name
                    _buildDataTableRow("Name: ", name),
                    _buildTableRowspacing(),

                    //age
                    _buildDataTableRow("Age: ", age),
                    _buildTableRowspacing(),

                    //phone no
                    _buildDataTableRow("PhoneNo: ", phoneNo),
                    _buildTableRowspacing(),

                    //City
                    _buildDataTableRow("City: ", city),
                    _buildTableRowspacing(),

                    //Country
                    _buildDataTableRow("Country: ", country),
                    _buildTableRowspacing(),

                    //Profile heading
                    _buildDataTableRow("Profile heading: ", profileHeading),
                    _buildTableRowspacing(),

                    //looking for
                    _buildDataTableRow("Looking for: ", lookingForInaPartner),
                    _buildTableRowspacing(),
                  ],
                ),
              ),
              //end start personal info

              //start Appearance
              const SizedBox(
                height: 30,
              ),
              _buildMainTitle("Appearance:"),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    //Height
                    _buildDataTableRow("Height: ", height),
                    _buildTableRowspacing(),

                    //Weight
                    _buildDataTableRow("Weight: ", weight),
                    _buildTableRowspacing(),

                    //boy type
                    _buildDataTableRow("Body Type: ", bodyType),
                    _buildTableRowspacing(),
                  ],
                ),
              ),
              //end Appearance

              //start Life style
              const SizedBox(
                height: 30,
              ),
              _buildMainTitle("Life style:"),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    //Drink
                    _buildDataTableRow("Drink: ", drink),
                    _buildTableRowspacing(),

                    //Smoke
                    _buildDataTableRow("Smoke: ", smoke),
                    _buildTableRowspacing(),

                    //Married
                    _buildDataTableRow("Married: ", martialStatus),
                    _buildTableRowspacing(),

                    //Childresn
                    _buildDataTableRow("Have Children: ", haveChildren),
                    _buildTableRowspacing(),

                    //Noof child
                    _buildDataTableRow("No of Children: ", noOfChildren),
                    _buildTableRowspacing(),

                    //Profession
                    _buildDataTableRow("Profession: ", profession),
                    _buildTableRowspacing(),

                    //empoyment
                    _buildDataTableRow("Employment Status: ", employmentStatus),
                    _buildTableRowspacing(),

                    //income
                    _buildDataTableRow("Income: ", income),
                    _buildTableRowspacing(),

                    //Living situation
                    _buildDataTableRow("Living Situation: ", livingSituatin),
                    _buildTableRowspacing(),

                    //Willing to reloacate
                    _buildDataTableRow(
                        "Willing to Relocate: ", willingToRelocate),
                    _buildTableRowspacing(),

                    //looking relationship
                    _buildDataTableRow(
                        "Looking Relationship: ", relationshipYouAreLookingFor),
                    _buildTableRowspacing(),
                  ],
                ),
              ),
              //end Life style

              //start Background - Cultureal values
              const SizedBox(
                height: 30,
              ),
              _buildMainTitle("Background - Cultureal values:"),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    //Nationality
                    _buildDataTableRow("Nationality: ", nationality),
                    _buildTableRowspacing(),

                    //Education
                    _buildDataTableRow("Education: ", education),
                    _buildTableRowspacing(),

                    //Language Spoken
                    _buildDataTableRow("Language Spoken: ", languageSpoken),
                    _buildTableRowspacing(),

                    //religion
                    _buildDataTableRow("Religion: ", religion),
                    _buildTableRowspacing(),

                    //ethnicity
                    _buildDataTableRow("Ethnicity: ", ethnicity),
                    _buildTableRowspacing(),
                  ],
                ),
              ),
              //end Background - Cultureal values
            ],
          ),
        ),
      ),
    );
  }

  Align _buildMainTitle(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TableRow _buildDataTableRow(String title, String data) {
    return TableRow(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        )
      ],
    );
  }

  TableRow _buildTableRowspacing() {
    return const TableRow(
      children: [
        Text(""),
        Text(""),
      ],
    );
  }
}
