import 'package:xsbdating/authenticationScreen/login_screen.dart';
import 'package:xsbdating/controllers/authentication_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyABOs5zw1kF12_LXAQjIsd0nPYDwT0T89M",
        authDomain: "dating-app-eb8d5.firebaseapp.com",
        projectId: "dating-app-eb8d5",
        storageBucket: "dating-app-eb8d5.appspot.com",
        messagingSenderId: "499981639119",
        appId: "1:499981639119:web:109497be6852a5666146ba"),
  ).then(
    (value) => Get.put(
      AuthenticationController(),
    ),
  );

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Datting app',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
