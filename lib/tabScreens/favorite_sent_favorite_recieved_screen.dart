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
  List favoritesList = [];

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
      getKeysDataFromUsersCollection(favoriteSentList);
    } else {
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favoriteReceived")
          .get();
      for (int i = 0; i < favoriteReceivedDocument.docs.length; i++) {
        favoriteReceivedtList.add(favoriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favoriteReceivedtList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          favoritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "My Favorites",
                style: TextStyle(
                  color: isFavoriteSetnClicked ? Colors.white : Colors.grey,
                  fontWeight: isFavoriteSetnClicked
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "I'm there Favorites!",
                style: TextStyle(
                  color: isFavoriteSetnClicked ? Colors.white : Colors.grey,
                  fontWeight: isFavoriteSetnClicked
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Favorite Sent Favorite Recieved",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
