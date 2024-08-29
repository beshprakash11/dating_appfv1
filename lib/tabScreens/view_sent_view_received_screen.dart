import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xsbdating/global.dart';
import 'package:flutter/material.dart';

class ViewSentViewReceivedScreen extends StatefulWidget {
  const ViewSentViewReceivedScreen({super.key});

  @override
  _ViewSentViewReceivedScreenState createState() =>
      _ViewSentViewReceivedScreenState();
}

class _ViewSentViewReceivedScreenState
    extends State<ViewSentViewReceivedScreen> {
  bool isViewSetnClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedtList = [];
  List viewList = [];

  geViewListKeys() async {
    if (isViewSetnClicked) {
      var viewSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("viewSent")
          .get();
      for (int i = 0; i < viewSentDocument.docs.length; i++) {
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewSentList);
    } else {
      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("viewReceived")
          .get();
      for (int i = 0; i < viewReceivedDocument.docs.length; i++) {
        viewReceivedtList.add(viewReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(viewReceivedtList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          viewList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewList;
    });
  }

  @override
  void initState() {
    super.initState();
    geViewListKeys();
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
                viewSentList.clear();
                viewSentList = [];
                viewReceivedtList.clear();
                viewReceivedtList = [];
                viewList.clear();
                viewList = [];
                setState(() {
                  isViewSetnClicked = true;
                });
                geViewListKeys();
              },
              child: Text(
                "My Views",
                style: TextStyle(
                  color: isViewSetnClicked ? Colors.grey : Colors.white,
                  fontWeight:
                      isViewSetnClicked ? FontWeight.normal : FontWeight.bold,
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
                viewSentList.clear();
                viewSentList = [];
                viewReceivedtList.clear();
                viewReceivedtList = [];
                viewList.clear();
                viewList = [];
                setState(() {
                  isViewSetnClicked = false;
                });
                geViewListKeys();
              },
              child: Text(
                "Who Viewed me!",
                style: TextStyle(
                  color: isViewSetnClicked ? Colors.white : Colors.grey,
                  fontWeight:
                      isViewSetnClicked ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: viewList.isEmpty
          ? _buildEmptyScreen()
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(
                viewList.length,
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
                                viewList[index]["imageProfile"],
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
                                    "${viewList[index]["name"]} • ${viewList[index]["age"]}",
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
                                          "${viewList[index]["city"]}, ${viewList[index]["country"]}",
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
