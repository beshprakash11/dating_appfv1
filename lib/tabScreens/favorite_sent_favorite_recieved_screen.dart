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
  getFavoriteListKeys() async {
    var favoriteSentDocument = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID.toString())
        .collection("favoriteSent")
        .get();
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
