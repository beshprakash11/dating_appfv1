import 'package:flutter/material.dart';

class FavoriteSentFavoriteRecievedScreen extends StatefulWidget {
  const FavoriteSentFavoriteRecievedScreen({Key? key}) : super(key: key);

  @override
  _FavoriteSentFavoriteRecievedScreenState createState() =>
      _FavoriteSentFavoriteRecievedScreenState();
}

class _FavoriteSentFavoriteRecievedScreenState
    extends State<FavoriteSentFavoriteRecievedScreen> {
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
