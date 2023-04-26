import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';
import 'package:trangsuchuunam/Screens/root.dart';
import 'package:trangsuchuunam/Screens/signup/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final matkhaucontroller = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: h * 1,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage("assets/images/login.jpg"),
              fit: BoxFit.fitWidth),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: h * 0.15),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hữu Nam SCJ",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  Image.asset(
                    "assets/images/nhanlogin.png",
                    width: h * 0.2,
                    height: h * 0.2,
                  ),
                  SizedBox(
                    height: h * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đăng nhập",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          Text(
                            "Chào mừng trở lại",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 153, 149, 149)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 199, 193, 193)),
                                borderRadius: BorderRadius.circular(50)),
                            height: 53,
                            minWidth: 53,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/images/facebook.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 199, 193, 193)),
                                borderRadius: BorderRadius.circular(50)),
                            height: 53,
                            minWidth: 53,
                            onPressed: () {},
                            child: Image.asset(
                              "assets/images/google.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    height: h * 0.07,
                    child: TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 168, 162, 162)))),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Container(
                    height: h * 0.07,
                    child: TextField(
                      controller: matkhaucontroller,
                      obscureText: _isObscure,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          hintText: "Mật khẩu",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 168, 162, 162)))),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Color(0xFFe5733f),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 199, 193, 193)),
                            borderRadius: BorderRadius.circular(50)),
                        height: 53,
                        minWidth: 160,
                        onPressed: () {
                          sigin();
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Quên mật khẩu ?",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bạn chưa có tài khoản"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Singup()),
                          );
                        },
                        child: Text(
                          "Đang kí",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
          final useid = FirebaseAuth.instance.currentUser;
          final id = useid?.uid;
          FirebaseFirestore.instance
              .collection("Users")
              .doc(id)
              .get()
              .then((value) {
            if (value['vaitro'] == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeAdmin()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Root()),
              );
            }
            ;
          });
        } else {
          print("erorr");
        }
      } on FirebaseAuthException catch (e) {
        CherryToast.error(
                title: Text(
                    "Tài khoản hoặc mật khẩu không chính xác hoặc chưa đang kí"))
            .show(context);
      }
    }
  }
}
