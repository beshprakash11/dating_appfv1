import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "User Details Screen",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
