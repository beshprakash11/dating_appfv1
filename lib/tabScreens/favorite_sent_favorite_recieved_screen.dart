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
              onPressed: () {
                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedtList.clear();
                favoriteReceivedtList = [];
                favoritesList.clear();
                favoritesList = [];
                setState(() {
                  isFavoriteSetnClicked = true;
                });
                getFavoriteListKeys();
              },
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
            const Text(
              "  |  ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () {
                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedtList.clear();
                favoriteReceivedtList = [];
                favoritesList.clear();
                favoritesList = [];
                setState(() {
                  isFavoriteSetnClicked = false;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "I'm there Favorite!",
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
        centerTitle: true,
      ),
      body: favoritesList.isEmpty
          ? _buildEmptyScreen()
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(
                favoritesList.length,
                (index) {
                  return GridTile(
                    child: Card(
                      color: Colors.blue.shade200,
                      child: GestureDetector(
                        onTap: () {},
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                favoritesList[index]["imageProfile"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "${favoritesList[index]["name"]} • ${favoritesList[index]["age"]}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${favoritesList[index]["city"]} • ${favoritesList[index]["country"]}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Center _buildEmptyScreen() {
    return const Center(
      child: Icon(
        Icons.person_off_sharp,
        color: Colors.white,
        size: 60,
      ),
    );
  }
}
