import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';

import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Screens/root.dart';
import 'package:trangsuchuunam/Screens/signup/signup.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:trangsuchuunam/Widgets/my_text_field.dart';
import '../../Models/bunny.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  late AnimationController animationController;
  late MyBunny myBunny;
  String? email;
  final emailcontroller = TextEditingController();
  final matkhaucontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.stop();
    myBunny = MyBunny(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width - 32;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 193, 222, 230),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: Lottie.asset(
              'assets/lottie/bunny.json',
              controller: animationController,
              width: 270,
              height: 270,
              onLoaded: (_) {
                setState(() {
                  animationController.duration = _.duration;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          MyTextField(
            textcontroller: emailcontroller,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            onHasFocus: (_) {
              myBunny.setTrackingState();
            },
            onChanged: (_) {
              myBunny.setEyesPosition(_getTextSize(_) / textFieldWidth);

              setState(() {
                email = _;
              });
            },
          ),
          const SizedBox(height: 10),
          MyTextField(
            textcontroller: matkhaucontroller,
            hintText: 'Mật Khẩu',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onHasFocus: (_) {
              if (_) {
                myBunny.setShyState();
              } else {
                myBunny.setPeekState();
              }
            },
            onObscureText: (_) {
              if (_) {
                myBunny.setShyState();
              } else {
                myBunny.setPeekState();
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  "Quên mật khẩu ?",
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Singup()));
                },
              ),
            ],
          ),
          CustomButtonLogin_Signup(
            onpressed: () {
              myBunny.setTrackingState();
              sigin();
            },
            text: "Đăng Nhập",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bạn chưa có tài khoản?'),
              TextButton(
                child: Text("Đăng kí"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Singup()));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Future sigin() async {
    if (emailcontroller.text == '' || matkhaucontroller.text == '') {
      CherryToast.warning(title: Text("Vui lòng kiểm tra thông tin nhập"))
          .show(context);
    } else {
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: matkhaucontroller.text.trim());

        if (user != null) {
          final useid = await FirebaseAuth.instance.currentUser;
          final id = useid?.uid;
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(id)
              .get()
              .then((value) {
            if (value['vaitro'] == 'admin') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeAdmin()));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Root()));
            }
            ;
          });
        } else {
          print("erorr");
        }
      } on FirebaseAuthException catch (e) {
        // CherryToast.error(title: Text(e.toString())).show(context);
        CherryToast.error(
                title: Text(
                    "Tài khoản hoặc mật khẩu không chính xác hoặc chưa đang kí"))
            .show(context);
      }
    }
  }
}

double _getTextSize(String text) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: const TextStyle(fontSize: 16.0)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size.width;
}
