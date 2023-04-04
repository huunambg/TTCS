import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:trangsuchuunam/Widgets/my_text_field.dart';
import 'package:trangsuchuunam/Models/bunny.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:trangsuchuunam/Models/user.dart';

class Singup extends StatefulWidget {
  const Singup({
    super.key,
  });

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  late AnimationController animationController;
  late MyBunny myBunny;
  String? email;
  final emailcontroller = TextEditingController();
  final matkhaucontroller = TextEditingController();
  final nhaplaimatkhaucontroller = TextEditingController();

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
          const SizedBox(height: 30),
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
            hintText: 'Mật khẩu',
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
          const SizedBox(height: 10),
          MyTextField(
            textcontroller: nhaplaimatkhaucontroller,
            hintText: 'Nhập lại mật khẩu',
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
          SizedBox(
            height: 20,
          ),
          CustomButtonLogin_Signup(
            onpressed: () {
              myBunny.setTrackingState();
              addUser();
            },
            text: "Đăng kí",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bạn đã có tài khoản quay lại?'),
              TextButton(
                child: Text("Đăng nhập"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  double _getTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16.0)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  void addUser() async {
    if (emailcontroller.text == '' ||
        matkhaucontroller.text == '' ||
        nhaplaimatkhaucontroller.text == '') {
      CherryToast.warning(title: Text("Vui lòng kiểm tra thông tin nhập"))
          .show(context);
    } else {
      if (matkhaucontroller.text != nhaplaimatkhaucontroller.text) {
        CherryToast.error(title: Text("Mật khẩu không khớp")).show(context);
      } else {
        try {
          final _newuser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailcontroller.text.trim(),
                  password: matkhaucontroller.text.trim());
          if (_newuser != null) {
            final docUsers =
                await FirebaseFirestore.instance.collection("Users");
            final userid = await FirebaseAuth.instance.currentUser;
            Users _user = new Users();
            final x = Services();
            _user.email = emailcontroller.text;
            _user.matkhau = matkhaucontroller.text;
            _user.vaitro = "người dùng";
            final id = userid?.uid;
            x.addUsers(_user, id!);
            CherryToast.success(title: Text("Đang kí thành tài khoản công"))
                .show(context);

            matkhaucontroller.text = '';
            nhaplaimatkhaucontroller.text = '';
          }
        } on FirebaseAuthException catch (e) {
          CherryToast.error(
                  title:
                      Text("Tài khoản ko đúng định dạng hoặc đã được sử dụng"))
              .show(context);
        }
      }
    }
  }
}
