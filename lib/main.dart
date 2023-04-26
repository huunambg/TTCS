import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Screens/root.dart';
import 'package:trangsuchuunam/Screens/signup/signup.dart';
import 'Screens/cart/cart.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class AppFonts {
  static const TextStyle regularText = TextStyle(
    fontFamily: 'Roboto', // tên font được tải từ Google Fonts
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
    color: Colors.black,
  );

  static const TextStyle boldText = TextStyle(
    fontFamily: 'Roboto', // tên font được tải từ Google Fonts
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: Colors.black,
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Screen',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Root();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.fadeIn(
        backgroundImage: Image.asset("assets/images/splash_bg.jpg"),
        childWidget: SizedBox(
          height: 230,
          width: 180,
          child: Column(
            children: [
              Image.asset(
                "assets/images/icon.png",
                height: 180,
                width: 180,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hữu Nam SCJ",
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 92, 58, 58),
                    fontWeight: FontWeight.bold,
                 ),
              )
            ],
          ),
        ),
        defaultNextScreen: Home(),
      ),
    );
  }
}
