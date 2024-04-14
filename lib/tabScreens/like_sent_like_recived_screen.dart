import 'package:flutter/material.dart';

class LikeSentLikeRecivedScreen extends StatefulWidget {
  const LikeSentLikeRecivedScreen({Key? key}) : super(key: key);

  @override
  _LikeSentLikeRecivedScreenState createState() =>
      _LikeSentLikeRecivedScreenState();
}

class _LikeSentLikeRecivedScreenState extends State<LikeSentLikeRecivedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Like Sent Like Recived",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
