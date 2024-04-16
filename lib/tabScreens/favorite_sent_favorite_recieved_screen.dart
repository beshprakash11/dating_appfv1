import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_appfv1/global.dart';
import 'package:flutter/material.dart';

class FavoriteSentFavoriteRecievedScreen extends StatefulWidget {
  const FavoriteSentFavoriteRecievedScreen({super.key});

  @override
  _FavoriteSentFavoriteRecievedScreenState createState() =>
      _FavoriteSentFavoriteRecievedScreenState();
}

class _FavoriteSentFavoriteRecievedScreenState
    extends State<FavoriteSentFavoriteRecievedScreen> {
  bool isFavoriteSetnClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedtList = [];

  getFavoriteListKeys() async {
    if (isFavoriteSetnClicked) {
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favoriteSent")
          .get();
      for (int i = 0; i < favoriteSentDocument.docs.length; i++) {
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
    } else {
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favoriteReceived")
          .get();
      for (int i = 0; i < favoriteReceivedDocument.docs.length; i++) {
        favoriteReceivedtList.add(favoriteReceivedDocument.docs[i].id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "FavoriteSentFavoriteRecievedScreen Screen",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
