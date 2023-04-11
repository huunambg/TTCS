import 'dart:developer';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Models/phanhoi.dart';
import 'package:trangsuchuunam/Screens/account/guide/huongdan.dart';
import 'package:trangsuchuunam/Screens/account/map/map.dart';
import 'package:trangsuchuunam/Screens/account/order/order.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final tencontroller = TextEditingController();
  final diachicontroller = TextEditingController();
  final imgcontroller = TextEditingController();
  final sdtcontroller = TextEditingController();
  String? img;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String? name;
  String? vaitro;
  void getname() {
    DocumentReference docRef =
        firestore.collection('Users').doc('${user?.uid}');
    docRef.get().then((doc) => {
          if (doc.exists)
            setState(() {
              name = doc.get('tenNguoiDung');
              vaitro = doc.get("vaitro");
              tencontroller.text = doc.get('tenNguoiDung');
              diachicontroller.text = doc.get('diaChi');
              sdtcontroller.text = "0${doc.get('sdt').toString()}";
              imgcontroller.text = doc.get('img');
              img = doc.get('img');
            })
        });
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 128, 115, 115))),
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(" Sửa thông tin"),
        centerTitle: true,
      ),
      body: ListView(
          padding:
              const EdgeInsets.only(top: 2, bottom: 10, left: 10, right: 10),
          children: [
            // COLUMN THAT WILL CONTAIN THE PROFILE
            Column(
              children: [
                img != "chưa cập nhật" && img != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "$img",
                        ))
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/acount.png")),
                SizedBox(height: 10),
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${user?.email}")
              ],
            ),

            SizedBox(height: 20),
            ItemEdit_OK(
              titile: "Tên người dùng",
              controller: tencontroller,
            ),
            ItemEdit_OK(
              titile: "Số điện thoại",
              controller: sdtcontroller,
            ),
            ItemEdit_OK(
              titile: "Địa chỉ",
              controller: diachicontroller,
            ),
            ItemEdit_OK(
              titile: "Ảnh",
              controller: imgcontroller,
            ),

            Container(
              margin: EdgeInsets.only(top: h * 0.04),
              width: w * 0.7,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: w * 0.7,
                height: h * 0.07,
                onPressed: () async {
                  if (imgcontroller.text == "" ||
                      tencontroller.text == "" ||
                      diachicontroller.text == "" ||
                      sdtcontroller.text == "" ||
                      int.parse(sdtcontroller.text) == null) {
                    CherryToast.warning(
                            title: Text(
                                "Vui lòng kiểm tra thông tin & không để trống thông tin"))
                        .show(context);
                  } else {
                    if (sdtcontroller.text.length < 9 ||
                        sdtcontroller.text.length > 14) {
                      CherryToast.warning(
                              title: Text(
                                  "Số điện thoại phải lớn hơn 9 số và nhỏ hơn 14 số "))
                          .show(context);
                    } else {
                      await firestore
                          .collection("Users")
                          .doc(user!.uid)
                          .update({
                        'tenNguoiDung': tencontroller.text,
                        'img': imgcontroller.text,
                        'sdt': int.parse(sdtcontroller.text),
                        'diaChi': diachicontroller.text
                      });
                      tencontroller.text = "";
                      imgcontroller.text = "";
                      sdtcontroller.text = "";
                      diachicontroller.text = "";
                      tencontroller.text = "";
                      CherryToast.success(
                              title: Text("Cập nhật thông tin thành công"))
                          .show(context);
                    }
                  }
                },
                color: Colors.blueAccent,
                child: Text(
                  "Cập nhật Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
    );
  }
}

class ItemEdit_OK extends StatelessWidget {
  const ItemEdit_OK({super.key, this.titile, this.controller});

  final controller;
  final String? titile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
          elevation: 4,
          shadowColor: Colors.black12,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                labelText: "$titile",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  15,
                ))),
          )),
    );
  }
}
