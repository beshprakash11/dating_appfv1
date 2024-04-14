import 'package:flutter/material.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({Key? key}) : super(key: key);

  @override
  _SwippingScreenState createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Swipping Screen",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
