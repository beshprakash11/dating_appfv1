import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xbsdating/controllers/profile-controller.dart';
import 'package:xbsdating/global.dart';
import 'package:xbsdating/tabScreens/user_details_screen.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  _SwippingScreenState createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";

  startChattingInWhatsApp(String receiverPhoneNummber) async {
    var amdrpodUrl =
        "whatsapp://send?phone=$receiverPhoneNummber&text=Hi, I found your profile on dating app.";
    var iosUrl =
        "https://wa.me/$receiverPhoneNummber?text=${Uri.parse("Hi, I found your profile on dating app.")}";

    try {
      if (Platform.isIOS) {
        await launchUrl((Uri.parse(iosUrl)));
      } else {
        await launchUrl((Uri.parse(amdrpodUrl)));
      }
    } on Exception {
      showDialog(
        context: context,
        builder: (BuildContext conttext) {
          return AlertDialog(
            title: const Text("WhatsApp Not found"),
            content: const Text("WhatsApp is not installed"),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Ok"),
              )
            ],
          );
        },
      );
    }
  }

  applyFilter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Matching Filter"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //start gender selection
                  const Text("I am looking for a:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text("Select gender"),
                      value: choosenGender,
                      underline: Container(),
                      items: [
                        "Male",
                        "Female",
                        "Others",
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          choosenGender = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //end gender selection

                  //start Country selection
                  const Text("who lives in:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text("Select country"),
                      value: choosenCountry,
                      underline: Container(),
                      items: [
                        "France",
                        "Germany",
                        "UK",
                        "USA",
                        "Canda",
                        "India",
                        "Nepal",
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          choosenCountry = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //end Country selection

                  //start age selection
                  const Text("who's age is equal to or above:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text("Select age"),
                      value: chooseAge,
                      underline: Container(),
                      items: ["18", "25", "30", "35", "40", "45", "50", "55"]
                          .map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chooseAge = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //end age selection
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    profileController.getResults();
                  },
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            itemCount: profileController.allUsersProfileList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final eachProfileInfo =
                  profileController.allUsersProfileList[index];
              return SafeArea(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        eachProfileInfo.imageProfile.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      //filter icon button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: () {
                              applyFilter();
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // start User data
                      GestureDetector(
                        onTap: () {
                          profileController.viewSentAndViewReceived(
                            eachProfileInfo.uid.toString(),
                            senderName,
                          );
                          //send user to profile person userDetailScreen
                          Get.to(
                            () => UserDetailsScreen(
                              userID: eachProfileInfo.uid.toString(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            //name
                            Text(
                              eachProfileInfo.name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //Age - city
                            Text(
                              "${eachProfileInfo.age} ⦿ ${eachProfileInfo.city}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 4,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            //Profession and religion
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // profession
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    eachProfileInfo.profession.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                // religion
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    eachProfileInfo.religion.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //country and ethnicity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // country
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    eachProfileInfo.country.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                // ethnicity
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    eachProfileInfo.ethnicity.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // end User data

                      const SizedBox(
                        height: 14,
                      ),

                      //start image button - favorite - chat - like
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //favorite button
                          GestureDetector(
                            onTap: () {
                              profileController.favoriteSentAndFavoriteReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );
                            },
                            child: Image.asset(
                              "images/favorite.png",
                              width: 60,
                            ),
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          //chat button
                          GestureDetector(
                            onTap: () {
                              startChattingInWhatsApp(
                                eachProfileInfo.phoneNo.toString(),
                              );
                            },
                            child: Image.asset(
                              "images/chat.png",
                              width: 60,
                            ),
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          //like button
                          GestureDetector(
                            onTap: () {
                              profileController.likeSentAndLikeReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );
                            },
                            child: Image.asset(
                              "images/like.png",
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                      //end image button - favorite - chat - like

                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
