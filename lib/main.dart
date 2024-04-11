import 'package:dating_appfv1/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyABOs5zw1kF12_LXAQjIsd0nPYDwT0T89M",
          authDomain: "dating-app-eb8d5.firebaseapp.com",
          projectId: "dating-app-eb8d5",
          storageBucket: "dating-app-eb8d5.appspot.com",
          messagingSenderId: "499981639119",
          appId: "1:499981639119:web:109497be6852a5666146ba"),
    );
  }*/
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyABOs5zw1kF12_LXAQjIsd0nPYDwT0T89M",
        authDomain: "dating-app-eb8d5.firebaseapp.com",
        projectId: "dating-app-eb8d5",
        storageBucket: "dating-app-eb8d5.appspot.com",
        messagingSenderId: "499981639119",
        appId: "1:499981639119:web:109497be6852a5666146ba"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
