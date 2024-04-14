import 'package:dating_appfv1/tabScreens/favorite_sent_favorite_recieved_screen.dart';
import 'package:dating_appfv1/tabScreens/like_sent_like_recived_screen.dart';
import 'package:dating_appfv1/tabScreens/swipping_screen.dart';
import 'package:dating_appfv1/tabScreens/user_details_screen.dart';
import 'package:dating_appfv1/tabScreens/view_sent_view_received_screen.dart';
import 'package:flutter/material.dart';

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
    const UserDetailsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
