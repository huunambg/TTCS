import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';

import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Screens/root.dart';
import 'package:trangsuchuunam/Screens/signup/signup.dart';

import 'Screens/cart/cart.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
