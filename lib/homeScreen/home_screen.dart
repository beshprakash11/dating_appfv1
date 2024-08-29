import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xbsdating/pushNotificationSystem/push_notification_system.dart';
import 'package:xbsdating/tabScreens/favorite_sent_favorite_recieved_screen.dart';
import 'package:xbsdating/tabScreens/like_sent_like_recived_screen.dart';
import 'package:xbsdating/tabScreens/swipping_screen.dart';
import 'package:xbsdating/tabScreens/user_details_screen.dart';
import 'package:xbsdating/tabScreens/view_sent_view_received_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List tabScreensList = [
    const SwippingScreen(),
    const ViewSentViewReceivedScreen(),
    const FavoriteSentFavoriteRecievedScreen(),
    const LikeSentLikeRecivedScreen(),
    UserDetailsScreen(
      userID: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  void initState() {
    super.initState();
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationReceived(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
            //swipe screen
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "",
          ),

          //View sent and received
          BottomNavigationBarItem(
            icon: Icon(
              Icons.remove_red_eye,
              size: 30,
            ),
            label: "",
          ),

          //favorite sent and recived
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              size: 30,
            ),
            label: "",
          ),

          //like sent and recived
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: "",
          ),

          //User details
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "",
          ),
        ],
      ),
      body: tabScreensList[screenIndex],
    );
  }
}
