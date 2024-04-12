import 'dart:io';

import 'package:dating_appfv1/controllers/authentication_controller.dart';
import 'package:dating_appfv1/widgets/custom_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
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

  bool showProgressBar = false;

  // auth controller
  var authController = AuthenticationController.authController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "to get Started Now.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            //choose image avatar
            authController.imageFile == null
                ? const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/profile_avatar.jpg"),
                    backgroundColor: Colors.black,
                  )
                : Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: FileImage(
                          File(
                            authController.imageFile!.path,
                          ),
                        ),
                      ),
                    ),
                  ),

            const SizedBox(
              height: 16,
            ),

            //control button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await authController.pickImageFileFormGallery();
                    setState(() {
                      authController.imageFile;
                    });
                  },
                  icon: const Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await authController.captureImageFromPhoneCamera();
                    setState(() {
                      authController.imageFile;
                    });
                  },
                  icon: const Icon(
                    Icons.camera_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
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

            //email field
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: emailTextEditingController,
                labelText: "Email",
                iconData: Icons.email_outlined,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //password field
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: passwordTextEditingController,
                labelText: "Password",
                iconData: Icons.lock_outline,
                isObscure: true,
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
                isObscure: true,
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
                isObscure: true,
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
                isObscure: true,
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
                isObscure: true,
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
                isObscure: true,
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
                isObscure: true,
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

            //create account button
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
                  if (authController.profileImage != null) {
                    if (
                        //Personal info
                        emailTextEditingController.text.trim().isNotEmpty &&
                            passwordTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            nameTextEditingController.text.trim().isNotEmpty &&
                            ageTextEditingController.text.trim().isNotEmpty &&
                            phoneNoTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            cityTextEditingController.text.trim().isNotEmpty &&
                            countryTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            profileHeadingTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            lookingForInaPartnerTextEditingController.text
                                .trim()
                                .isNotEmpty &&

                            //Appearance
                            heightTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            weightTextEditingController.text
                                .trim()
                                .isNotEmpty &&
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
                            incomeTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            livingSituationTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            willingToRelocateTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            relationshipYouAreLookingForTextEditingController
                                .text
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
                      showProgressBar = true;
                      await authController.createNewUserAccount(
                        //Personal info
                        authController.profileImage!,
                        emailTextEditingController.text.trim(),
                        passwordTextEditingController.text.trim(),
                        nameTextEditingController.text.trim(),
                        ageTextEditingController.text.trim(),
                        phoneNoTextEditingController.text.trim(),
                        cityTextEditingController.text.trim(),
                        countryTextEditingController.text.trim(),
                        profileHeadingTextEditingController.text.trim(),
                        lookingForInaPartnerTextEditingController.text.trim(),

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
                        relationshipYouAreLookingForTextEditingController.text
                            .trim(),

                        //Background - cultural values
                        nationalityTextEditingController.text.trim(),
                        educationTextEditingController.text.trim(),
                        languageSpokenTextEditingController.text.trim(),
                        religionTextEditingController.text.trim(),
                        ethnicityTextEditingController.text.trim(),
                      );
                      setState(() {
                        showProgressBar = false;
                      });
                    } else {
                      Get.snackbar(
                        "A field is Empty",
                        "Please fill out all field in text fields.",
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Image File Missing",
                      "Please pick image form gallery or capture with Camera",
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Create Account",
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
            //already have an account login here button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Text(
                    "Login Here",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            showProgressBar == true
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                  )
                : Container(),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
