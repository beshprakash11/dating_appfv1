import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xbsdating/controllers/authentication_controller.dart';
import 'package:xbsdating/global.dart';
import 'package:xbsdating/homeScreen/home_screen.dart';
import 'package:xbsdating/widgets/custom_text_field_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlList = [];
  double val = 0;

  //Personal info
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController =
      TextEditingController();
  TextEditingController lookingForInaPartnerTextEditingController =
      TextEditingController();

  //Appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //Life style
  TextEditingController drinkingTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController martilStatusTextEditingController =
      TextEditingController();
  TextEditingController haveChildrenTextEditingController =
      TextEditingController();
  TextEditingController noOfChildrenTextEditingController =
      TextEditingController();
  TextEditingController professionTextEditingController =
      TextEditingController();
  TextEditingController employmentStatusTextEditingController =
      TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController =
      TextEditingController();
  TextEditingController willingToRelocateTextEditingController =
      TextEditingController();
  TextEditingController relationshipYouAreLookingForTextEditingController =
      TextEditingController();

  //Background - cultural values
  TextEditingController nationalityTextEditingController =
      TextEditingController();
  TextEditingController educationTextEditingController =
      TextEditingController();
  TextEditingController languageSpokenTextEditingController =
      TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController =
      TextEditingController();

  //personal info
  String name = "";
  String age = "";
  String gender = "";
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

  bool showProgressBar = false;
  // auth controller
  var authController = AuthenticationController.authController;

  chooseImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      var refImages = FirebaseStorage.instance.ref().child(
          "images/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg");
      await refImages.putFile(img).whenComplete(
        () async {
          await refImages.getDownloadURL().then(
            (urlImage) {
              urlList.add(urlImage);
              i++;
            },
          );
        },
      );
    }
  }

  retrieveUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          //personal info
          name = snapshot.data()!["name"];
          nameTextEditingController.text = name;
          age = snapshot.data()!["age"].toString();
          ageTextEditingController.text = age;
          gender = snapshot.data()!["gender"];
          genderTextEditingController.text = gender;
          phoneNo = snapshot.data()!["phoneNo"];
          phoneNoTextEditingController.text = phoneNo;
          city = snapshot.data()!["city"];
          cityTextEditingController.text = city;
          country = snapshot.data()!["country"];
          countryTextEditingController.text = country;
          profileHeading = snapshot.data()!["profileHeading"];
          profileHeadingTextEditingController.text = profileHeading;
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
          lookingForInaPartnerTextEditingController.text = lookingForInaPartner;

          //Appearance
          height = snapshot.data()!["height"];
          heightTextEditingController.text = height;
          weight = snapshot.data()!["weight"];
          weightTextEditingController.text = weight;
          bodyType = snapshot.data()!["bodyType"];
          bodyTypeTextEditingController.text = bodyType;

          //Life style
          drink = snapshot.data()!["drink"];
          drinkingTextEditingController.text = drink;
          smoke = snapshot.data()!["smoke"];
          smokeTextEditingController.text = smoke;
          martialStatus = snapshot.data()!["martialStatus"];
          martilStatusTextEditingController.text = martialStatus;
          haveChildren = snapshot.data()!["haveChildren"];
          haveChildrenTextEditingController.text = haveChildren;
          noOfChildren = snapshot.data()!["noOfChildren"];
          noOfChildrenTextEditingController.text = noOfChildren;
          profession = snapshot.data()!["profession"];
          professionTextEditingController.text = profession;
          employmentStatus = snapshot.data()!["employmentStatus"];
          employmentStatusTextEditingController.text = employmentStatus;
          income = snapshot.data()!["income"];
          incomeTextEditingController.text = income;
          livingSituatin = snapshot.data()!["livingSituatin"];
          livingSituationTextEditingController.text = livingSituatin;
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          willingToRelocateTextEditingController.text = willingToRelocate;
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];
          relationshipYouAreLookingForTextEditingController.text =
              relationshipYouAreLookingFor;

          //Background - Cultureal values
          nationality = snapshot.data()!["nationality"];
          nationalityTextEditingController.text = nationality;
          education = snapshot.data()!["education"];
          educationTextEditingController.text = education;
          languageSpoken = snapshot.data()!["languageSpoken"];
          languageSpokenTextEditingController.text = languageSpoken;
          religion = snapshot.data()!["religion"];
          religionTextEditingController.text = religion;
          ethnicity = snapshot.data()!["ethnicity"];
          ethnicityTextEditingController.text = ethnicity;
        });
      }
    });
  }

  updateUserDataToFirestoreDatabase(
    //personal info
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
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: SizedBox(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Uloading images...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    await uploadImages();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .update({
      //Personal info
      "name": name,
      "age": int.parse(age),
      "gender": gender.toLowerCase(),
      "phoneNo": phoneNo,
      "city": city,
      "country": country,
      "profileHeading": profileHeading,
      "lookingForInaPartner": lookingForInaPartner,

      //Appearance
      "height": height,
      "weight": weight,
      "bodyType": bodyType,

      //life style
      "drink": drink,
      "smoke": smoke,
      "martialStatus": martialStatus,
      "haveChildren": haveChildren,
      "noOfChildren": noOfChildren,
      "profession": profession,
      "employmentStatus": employmentStatus,
      "income": income,
      "livingSituatin": livingSituatin,
      "willingToRelocate": willingToRelocate,
      "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

      //Background values
      "nationality": nationality,
      "education": education,
      "languageSpoken": languageSpoken,
      "religion": religion,
      "ethnicity": ethnicity,

      //images
      "urlImage1": urlList[0].toString(),
      "urlImage2": urlList[1].toString(),
      "urlImage3": urlList[2].toString(),
      "urlImage4": urlList[3].toString(),
      "urlImage5": urlList[4].toString(),
    });

    Get.snackbar("Updated", "Your account has been updated successfully.");

    Get.to(() => const HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlList.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 Images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
                  onPressed: () {
                    if (_image.length == 5) {
                      setState(() {
                        uploading = true;
                        next = true;
                      });
                    } else {
                      Get.snackbar("5 Images", "Please choose 5 images");
                    }
                  },
                  icon: const Icon(
                    Icons.navigate_next_outlined,
                    size: 36,
                  ),
                ),
        ],
      ),
      body: next ? _buildAccountEditingView() : _buildStack(),
    );
  }

  SingleChildScrollView _buildAccountEditingView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 2,
            ),
            /**
             * Personal information field
             */
            const Text(
              "Personal Info:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //user name
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: nameTextEditingController,
                labelText: "Name",
                iconData: Icons.person_outline,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //age
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: ageTextEditingController,
                labelText: "Age",
                iconData: Icons.numbers,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //gender
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: genderTextEditingController,
                labelText: "Gender",
                iconData: Icons.person_pin,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //phoneNo
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: phoneNoTextEditingController,
                labelText: "Phone",
                iconData: Icons.phone,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //city
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: cityTextEditingController,
                labelText: "City",
                iconData: Icons.location_city,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //Country
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: countryTextEditingController,
                labelText: "Country",
                iconData: Icons.location_city,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //profileHeading
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: profileHeadingTextEditingController,
                labelText: "Profile Heading",
                iconData: Icons.text_fields,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //lookingForInaPartner
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: lookingForInaPartnerTextEditingController,
                labelText: "Whar are you looking for in a Partner?",
                iconData: Icons.face,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            /**
             * Appearance information field
             */
            const Text(
              "Appearance:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            //height
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: heightTextEditingController,
                labelText: "Height",
                iconData: Icons.insert_chart,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //weight
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: weightTextEditingController,
                labelText: "Weight",
                iconData: Icons.table_chart,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //bodyType
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: bodyTypeTextEditingController,
                labelText: "Body Type",
                iconData: Icons.type_specimen,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            /**
             * Life style field
             */
            const Text(
              "Life Style:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            //drink
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: drinkingTextEditingController,
                labelText: "Drink",
                iconData: Icons.local_drink_outlined,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //smoke
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: smokeTextEditingController,
                labelText: "Smoke",
                iconData: Icons.smoking_rooms,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //martialStatus
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: martilStatusTextEditingController,
                labelText: "Martial Status",
                iconData: CupertinoIcons.person_2,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //haveChildren
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: haveChildrenTextEditingController,
                labelText: "Do you have Children?",
                iconData: CupertinoIcons.person_3_fill,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //noOfChildren
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: noOfChildrenTextEditingController,
                labelText: "Number of Children",
                iconData: CupertinoIcons.person_3_fill,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //profession
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: professionTextEditingController,
                labelText: "Profession",
                iconData: Icons.business_center,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //employmentStatus
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: employmentStatusTextEditingController,
                labelText: "Employment Status",
                iconData: CupertinoIcons.rectangle_stack_person_crop_fill,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //income
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: incomeTextEditingController,
                labelText: "Income",
                iconData: CupertinoIcons.money_dollar_circle,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //livingSituation
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: livingSituationTextEditingController,
                labelText: "Living Situation",
                iconData: CupertinoIcons.person_2_square_stack,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //willingToRelocate
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: willingToRelocateTextEditingController,
                labelText: "Are you willing to Relocate?",
                iconData: CupertinoIcons.person_2,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //relationshipYouAreLookingFor
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController:
                    relationshipYouAreLookingForTextEditingController,
                labelText: "What relationship you are looking for?",
                iconData: CupertinoIcons.person_2,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            /**
             * Background - Cultural field
             */
            const Text(
              "Background - Cultural Values:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            //nationality
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: nationalityTextEditingController,
                labelText: "Nationality",
                iconData: Icons.flag_circle_outlined,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //education
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: educationTextEditingController,
                labelText: "Education",
                iconData: Icons.history_edu,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //languageSpoken
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: languageSpokenTextEditingController,
                labelText: "Language Spoken",
                iconData: CupertinoIcons.person_badge_plus_fill,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //religion
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: religionTextEditingController,
                labelText: "Religion",
                iconData: CupertinoIcons.checkmark_seal_fill,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //ethnicity
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: ethnicityTextEditingController,
                labelText: "Ethnicity",
                iconData: CupertinoIcons.eye,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //update account button
            Container(
              width: MediaQuery.of(context).size.width - 36,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  )),
              child: InkWell(
                onTap: () async {
                  if (
                      //Personal info
                      nameTextEditingController.text.trim().isNotEmpty &&
                          ageTextEditingController.text.trim().isNotEmpty &&
                          genderTextEditingController.text.trim().isNotEmpty &&
                          phoneNoTextEditingController.text.trim().isNotEmpty &&
                          cityTextEditingController.text.trim().isNotEmpty &&
                          countryTextEditingController.text.trim().isNotEmpty &&
                          profileHeadingTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          lookingForInaPartnerTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Appearance
                          heightTextEditingController.text.trim().isNotEmpty &&
                          weightTextEditingController.text.trim().isNotEmpty &&
                          bodyTypeTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Life style
                          drinkingTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          smokeTextEditingController.text.trim().isNotEmpty &&
                          martilStatusTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          haveChildrenTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          noOfChildrenTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          professionTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          employmentStatusTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          incomeTextEditingController.text.trim().isNotEmpty &&
                          livingSituationTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          willingToRelocateTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          relationshipYouAreLookingForTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Background - cultural values
                          nationalityTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          educationTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          languageSpokenTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          religionTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          ethnicityTextEditingController.text
                              .trim()
                              .isNotEmpty) {
                    _image.length > 0
                        ? await updateUserDataToFirestoreDatabase(
                            //Personal info
                            nameTextEditingController.text.trim(),
                            ageTextEditingController.text.trim(),
                            genderTextEditingController.text.trim(),
                            phoneNoTextEditingController.text.trim(),
                            cityTextEditingController.text.trim(),
                            countryTextEditingController.text.trim(),
                            profileHeadingTextEditingController.text.trim(),
                            lookingForInaPartnerTextEditingController.text
                                .trim(),

                            //Appearance
                            heightTextEditingController.text.trim(),
                            weightTextEditingController.text.trim(),
                            bodyTypeTextEditingController.text.trim(),

                            //Life style
                            drinkingTextEditingController.text.trim(),
                            smokeTextEditingController.text.trim(),
                            martilStatusTextEditingController.text.trim(),
                            haveChildrenTextEditingController.text.trim(),
                            noOfChildrenTextEditingController.text.trim(),
                            professionTextEditingController.text.trim(),
                            employmentStatusTextEditingController.text.trim(),
                            incomeTextEditingController.text.trim(),
                            livingSituationTextEditingController.text.trim(),
                            willingToRelocateTextEditingController.text.trim(),
                            relationshipYouAreLookingForTextEditingController
                                .text
                                .trim(),

                            //Background - cultural values
                            nationalityTextEditingController.text.trim(),
                            educationTextEditingController.text.trim(),
                            languageSpokenTextEditingController.text.trim(),
                            religionTextEditingController.text.trim(),
                            ethnicityTextEditingController.text.trim(),
                          )
                        : null;
                  } else {
                    Get.snackbar(
                      "A field is Empty",
                      "Please fill out all field in text fields.",
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildStack() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: GridView.builder(
            itemCount: _image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return index == 0
                  ? _buildUploadImage()
                  : _buildImageDisplay(index);
            },
          ),
        ),
      ],
    );
  }

  Container _buildUploadImage() {
    return Container(
      color: Colors.white30,
      child: Center(
        child: IconButton(
          onPressed: () {
            if (_image.length < 5) {
              !uploading ? chooseImage() : null;
            } else {
              setState(() {
                uploading == true;
              });
              Get.snackbar("5 Image choosen.", "5 Images Already selected!");
            }
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Container _buildImageDisplay(int index) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            _image[index - 1],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
