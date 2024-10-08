import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xbsdating/global.dart';
import 'package:xbsdating/models/person.dart';

class ProfileController extends GetxController {
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  getResults() {
    onInit();
  }

  @override
  void onInit() {
    super.onInit();

    if (choosenGender == null || choosenCountry == null || chooseAge == null) {
      usersProfileList.bindStream(
        FirebaseFirestore.instance
            .collection("users")
            .where("uid",
                isNotEqualTo: FirebaseAuth
                    .instance.currentUser!.uid) //does not take my own id
            .snapshots()
            .map(
          (QuerySnapshot querySnapshot) {
            List<Person> profliesList = [];
            for (var eachProfile in querySnapshot.docs) {
              profliesList.add(Person.formDataSnapshot(eachProfile));
            }
            return profliesList;
          },
        ), // user data
      );
    } else {
      usersProfileList.bindStream(
        FirebaseFirestore.instance
            .collection("users")
            .where("gender", isEqualTo: choosenGender.toString().toLowerCase())
            .where("country", isEqualTo: choosenCountry.toString())
            .where("age",
                isGreaterThanOrEqualTo: int.parse(chooseAge.toString()))
            .snapshots()
            .map(
          (QuerySnapshot querySnapshot) {
            List<Person> profliesList = [];
            for (var eachProfile in querySnapshot.docs) {
              profliesList.add(Person.formDataSnapshot(eachProfile));
            }
            return profliesList;
          },
        ), // user data
      );
    }
  }

  // start FavoriteSentAndFavoriteReceived
  favoriteSentAndFavoriteReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID)
        .collection("favoriteReceived")
        .doc(currentUserID)
        .get();

    //remove the favorite from database
    if (document.exists) {
      // remove currentUserID from the favoriteReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("favoriteReceived")
          .doc(currentUserID)
          .delete();

      // remove profile person [toUserID] from the favoriteSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("favoriteSent")
          .doc(toUserID)
          .delete();
    } else //mark as favorite// add favorite in database
    {
      // add currentUserID to the favoriteReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("favoriteReceived")
          .doc(currentUserID)
          .set({});

      // add profile person [toUserID] to the favoriteSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("favoriteSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Favorite", senderName);
    }
    update();
  }
  // start FavoriteSentAndFavoriteReceived

  // start likeSentAndLikeeReceived
  likeSentAndLikeReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID)
        .collection("likeReceived")
        .doc(currentUserID)
        .get();

    //remove the like from database
    if (document.exists) {
      // remove currentUserID from the likeReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(currentUserID)
          .delete();

      // remove profile person [toUserID] from the likeSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("likeSent")
          .doc(toUserID)
          .delete();
    } else //mark as like// add like in database
    {
      // add currentUserID to the likeReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(currentUserID)
          .set({});

      // add profile person [toUserID] to the likeSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("likeSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Like", senderName);
    }
    update();
  }
  // start likeSentAndLikeReceived

  // start viewSentAndViewReceived
  viewSentAndViewReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID)
        .collection("viewReceived")
        .doc(currentUserID)
        .get();

    //remove the view from database
    if (document.exists) {
      //view list
      print("already in view list");
    } else //add new view in database
    {
      // add currentUserID to the viewReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("viewReceived")
          .doc(currentUserID)
          .set({});

      // add profile person [toUserID] to the viewSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("viewSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "View", senderName);
    }
    update();
  }
  // start viewSentAndViewReceived

  //start notificaion
  sendNotificationToUser(receiverID, featureType, senderName) async {
    String userDeviceToken = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(receiverID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["userDeviceToken"] != null) {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });

    notificationFormat(
      userDeviceToken,
      receiverID,
      featureType,
      senderName,
    );
  }

  //end notificaion

  //start notification format
  void notificationFormat(
    userDeviceToken,
    receiverID,
    featureType,
    senderName,
  ) {
    Map<String, String> headerNotification = {
      "Content-Type": "application/json",
      "Authorization": fcmServerToken,
    };
    Map bodyNotification = {
      "body":
          "You have received a new $featureType from $senderName. Click to see.",
      "title": "New $featureType",
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userID": receiverID,
      "senderID": currentUserID,
    };

    Map notificationOfficialFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": userDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(notificationOfficialFormat),
    );
  }
  //end notification format
}
