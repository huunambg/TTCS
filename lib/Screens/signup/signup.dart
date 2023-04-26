import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trangsuchuunam/Models/user.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  bool _isObscure = true;
  final user = FirebaseAuth.instance.currentUser;
  String? email;
  final emailcontroller = TextEditingController();
  final matkhaucontroller = TextEditingController();
  final nhaplaimatkhaucontroller = TextEditingController();
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
              SizedBox(
                height: h * 0.15,
              ),
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
              Container(
                margin: EdgeInsets.only(top: h * 0.005),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đang kí",
                      style: TextStyle(fontSize: 20),
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
                                    color:
                                        Color.fromARGB(255, 168, 162, 162)))),
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
                                    color:
                                        Color.fromARGB(255, 168, 162, 162)))),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.015,
                    ),
                    Container(
                      height: h * 0.07,
                      child: TextField(
                        controller: nhaplaimatkhaucontroller,
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
                            hintText: "Nhập lại mật khẩu",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color:
                                        Color.fromARGB(255, 168, 162, 162)))),
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
                            addUser();
                          },
                          child: Text(
                            "Đang kí",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.065,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Quay trở lại đăng nhập"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            "Đăng nhập",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
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
