import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeSentLikeRecivedScreen extends StatefulWidget {
  const LikeSentLikeRecivedScreen({super.key});

  @override
  _LikeSentLikeRecivedScreenState createState() =>
      _LikeSentLikeRecivedScreenState();
}

class _LikeSentLikeRecivedScreenState extends State<LikeSentLikeRecivedScreen> {
  bool isLikeSetnClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedtList = [];
  List likeList = [];

  getLikeListKeys() async {
    if (isLikeSetnClicked) {
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeSent")
          .get();
      for (int i = 0; i < likeSentDocument.docs.length; i++) {
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeSentList);
    } else {
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeReceived")
          .get();
      for (int i = 0; i < likeReceivedDocument.docs.length; i++) {
        likeReceivedtList.add(likeReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeReceivedtList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          likeList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likeList;
    });
  }

  @override
  void initState() {
    super.initState();
    getLikeListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                likeSentList.clear();
                likeSentList = [];
                likeReceivedtList.clear();
                likeReceivedtList = [];
                likeList.clear();
                likeList = [];
                setState(() {
                  isLikeSetnClicked = true;
                });
                getLikeListKeys();
              },
              child: Text(
                "My Likes",
                style: TextStyle(
                  color: isLikeSetnClicked ? Colors.grey : Colors.white,
                  fontWeight:
                      isLikeSetnClicked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
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
                likeSentList.clear();
                likeSentList = [];
                likeReceivedtList.clear();
                likeReceivedtList = [];
                likeList.clear();
                likeList = [];
                setState(() {
                  isLikeSetnClicked = false;
                });
                getLikeListKeys();
              },
              child: Text(
                "Who liked me!",
                style: TextStyle(
                  color: isLikeSetnClicked ? Colors.white : Colors.grey,
                  fontWeight:
                      isLikeSetnClicked ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: likeList.isEmpty
          ? _buildEmptyScreen()
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(
                likeList.length,
                (index) {
                  return GridTile(
                    child: Card(
                      color: Colors.blue.shade200,
                      child: GestureDetector(
                        onTap: () {},
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                likeList[index]["imageProfile"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),

                                  //name - age
                                  Text(
                                    "${likeList[index]["name"]} • ${likeList[index]["age"]}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),

                                  //city-country
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${likeList[index]["city"]}, ${likeList[index]["country"]}",
                                          maxLines: 2,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
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
