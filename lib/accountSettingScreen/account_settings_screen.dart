import 'dart:io';

import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlList = [];
  double val = 0;

  chooseImage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 Images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next_outlined,
                    size: 36,
                  ),
                ),
        ],
      ),
      body: next ? SingleChildScrollView() : _buildStack(),
    );
  }

  Stack _buildStack() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: GridView.builder(
            itemCount: _image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return index == 0
                  ? Container(
                      color: Colors.white30,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            !uploading ? chooseImage() : null;
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    )
                  : _buildImageDisplay(index);
            },
          ),
        ),
      ],
    );
  }

  Container _buildImageDisplay(int index) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            _image[index - 1],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}