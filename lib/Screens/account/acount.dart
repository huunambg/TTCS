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
import 'package:trangsuchuunam/Screens/account/profile/editprofile.dart';
import 'package:trangsuchuunam/Screens/admin/homeadmin.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:intl/intl.dart';

class Acount extends StatefulWidget {
  const Acount({super.key});

  @override
  State<Acount> createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String? name;
  String? vaitro;
  String? img;
  final phanhoi = FirebaseFirestore.instance.collection("PhanHoi");
  final phanhoicontroller = TextEditingController();
  void getname() {
    DocumentReference docRef =
        firestore.collection('Users').doc('${user?.uid}');
    docRef.get().then((doc) => {
          if (doc.exists)
            setState(() {
              name = doc.get('tenNguoiDung');
              vaitro = doc.get("vaitro");
              img = doc.get("img");
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
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 128, 115, 115))),
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text("Tài khoản"),
        centerTitle: true,
        actions: [
          vaitro == "admin"
              ? IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeAdmin()),
                    );
                  },
                  icon: Icon(Icons.navigate_next_outlined))
              : IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  icon: Icon(Icons.manage_accounts_outlined))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 2, bottom: 10, left: 10, right: 10),
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
                      backgroundImage: AssetImage("assets/images/acount.png")),
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
          ItemAccount_OK(
              icon: Ionicons.bag_handle_outline,
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              titile: "Đơn hàng"),
          ItemAccount_OK(
              icon: Icons.location_on_outlined,
              onpressed: () {},
              titile: "Địa chỉ"),
          ItemAccount_OK(
              icon: CupertinoIcons.bell, onpressed: () {}, titile: "Thông báo"),
          ItemAccount_OK(
              icon: Ionicons.alert_circle_outline,
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HuongDan()));
              },
              titile: "Hướng dẫn"),
          ItemAccount_OK(
              icon: Ionicons.chatbox_outline,
              onpressed: () {
                NDialog(
                  dialogStyle: DialogStyle(
                      titleDivider: true,
                      backgroundColor: Color.fromARGB(255, 231, 205, 195)),
                  title: Text(
                    "Phản hồi",
                    textAlign: TextAlign.center,
                  ),
                  content: TextField(
                    controller: phanhoicontroller,
                    decoration:
                        InputDecoration(labelText: "Nhập nội dung phản hồi"),
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
                                      title: Text("Cảm ơn bản đã gửi phản hồi"))
                                  .show(context);
                            }
                          }
                        }),
                  ],
                ).show(context);
              },
              titile: "Phản hồi"),
          ItemAccount_OK(
              icon: Ionicons.arrow_back_circle_outline,
              onpressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              titile: "Đăng xuất"),
        ],
      ),
    );
  }
}

class ItemAccount_OK extends StatelessWidget {
  const ItemAccount_OK(
      {super.key,
      required this.icon,
      required this.onpressed,
      required this.titile});
  final icon;
  final GestureTapCallback onpressed;
  final String titile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black12,
        child: ListTile(
          onTap: onpressed,
          leading: Icon(icon),
          title: Text(titile),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
