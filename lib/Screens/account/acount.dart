import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Models/phanhoi.dart';
import 'package:trangsuchuunam/Screens/account/components/cusstom_item_account.dart';
import 'package:trangsuchuunam/Screens/account/guide/huongdan.dart';
import 'package:trangsuchuunam/Screens/account/map/map.dart';
import 'package:trangsuchuunam/Screens/account/order/order.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String? name;
  final phanhoi = FirebaseFirestore.instance.collection("PhanHoi");
  final phanhoicontroller = TextEditingController();
  void getname() {
    DocumentReference docRef =
        firestore.collection('Users').doc('${user?.uid}');
    docRef.get().then((doc) => {
          if (doc.exists)
            {name = doc.get('tenNguoiDung')}
          else
            name = user!.email
        });
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    getname();
    ;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.asset("assets/images/acount.png")),
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 128, 115, 115))),
        elevation: 0,
        backgroundColor: Colors.red,
        title: name == null ? Text("${user!.email}") : Text("${name}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: h * 0.7,
            child: Column(
              children: [
                CusstomItemAcount(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderScreen()));
                    },
                    text: "Đơn mua",
                    iconn: Ionicons.bag_handle_outline),
                CusstomItemAcount(
                    onpressed: () {},
                    text: "Địa chỉ",
                    iconn: Ionicons.navigate_outline),
                CusstomItemAcount(
                    onpressed: () {},
                    text: "Thông báo",
                    iconn: Ionicons.notifications_outline),
                CusstomItemAcount(
                    onpressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HuongDan()));
                    },
                    text: "Hướng dẫn",
                    iconn: Ionicons.alert_circle_outline),
                CusstomItemAcount(
                    onpressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => MapScreen()));
                    },
                    text: "Vị trí của hàng",
                    iconn: Icons.place_outlined),
                CusstomItemAcount(
                    onpressed: () {
                      NDialog(
                        dialogStyle: DialogStyle(
                            titleDivider: true,
                            backgroundColor:
                                Color.fromARGB(255, 231, 205, 195)),
                        title: Text(
                          "Phản hồi",
                          textAlign: TextAlign.center,
                        ),
                        content: TextField(
                          controller: phanhoicontroller,
                          decoration: InputDecoration(
                              labelText: "Nhập nội dung phản hồi"),
                        ),
                        actions: <Widget>[
                          TextButton(
                              child: Text("Quay lại"),
                              onPressed: () => Navigator.pop(context)),
                          TextButton(
                              child: Text("Gửi"),
                              onPressed: () async {
                                if (user != null) {
                                  if (phanhoicontroller.text != "") {
                                    Services x = new Services();
                                    PhanHoi _phanHoi = new PhanHoi();
                                    _phanHoi.noiDung = phanhoicontroller.text;
                                    _phanHoi.thoiGian =
                                        DateFormat('dd-MM-yyyy KK:mm a')
                                            .format(DateTime.now())
                                            .toString();
                                    _phanHoi.tenNguoiDung = name;
                                    await x.addPhanHoi(_phanHoi);
                                    setState(() {
                                      phanhoicontroller.text = "";
                                    });
                                    Navigator.pop(context);
                                    CherryToast.success(
                                            title: Text(
                                                "Cảm ơn bản đã gửi phản hồi"))
                                        .show(context);
                                  }
                                }
                              }),
                        ],
                      ).show(context);
                    },
                    text: "Phản hồi",
                    iconn: Ionicons.chatbox_outline),
              ],
            ),
          ),
          CustomButtonLogin_Signup(
              text: "Đăng xuất",
              onpressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              })
        ],
      ),
    );
  }
}
