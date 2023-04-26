import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';

class QLNguoiDung extends StatefulWidget {
  const QLNguoiDung({super.key});

  @override
  State<QLNguoiDung> createState() => _QLNguoiDungState();
}

class _QLNguoiDungState extends State<QLNguoiDung> {
  final user = FirebaseAuth.instance.currentUser;
  final tenNguoiDungcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final sdtcontroller = TextEditingController();
  final diachicontroller = TextEditingController();
  final imgcontroller = TextEditingController();
  final tuoicontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý người dùng"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Loi hihi"),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(3.5),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () {
                            NDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text(
                                  "${snapshot.data!.docs[index]['tenNguoiDung']}"),
                              content: Text("Vui lòng chọn chức năng"),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("Sửa"),
                                    onPressed: () {
                                      tenNguoiDungcontroller.text = snapshot
                                          .data!.docs[index]['tenNguoiDung'];
                                      emailcontroller.text =
                                          snapshot.data!.docs[index]['email'];
                                      sdtcontroller.text = snapshot
                                          .data!.docs[index]['sdt']
                                          .toString();
                                      diachicontroller.text =
                                          snapshot.data!.docs[index]['diaChi'];
                                      imgcontroller.text =
                                          snapshot.data!.docs[index]['img'];
                                      tuoicontroller.text = snapshot
                                          .data!.docs[index]['tuoi']
                                          .toString();
                                      Navigator.pop(context);
                                      NDialog(
                                        dialogStyle:
                                            DialogStyle(titleDivider: true),
                                        title: Text(
                                            "${snapshot.data!.docs[index]['tenNguoiDung']}"),
                                        content: Container(
                                          height: h * 0.5,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                    tenNguoiDungcontroller,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        "Tên người dùng"),
                                              ),
                                              TextField(
                                                controller: emailcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Email"),
                                              ),
                                              TextField(
                                                controller: sdtcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "SDT"),
                                              ),
                                              TextField(
                                                controller: diachicontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Địa chỉ"),
                                              ),
                                              TextField(
                                                controller: imgcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Ảnh"),
                                              ),
                                              TextField(
                                                controller: tuoicontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Tuổi"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("Lưu"),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                if (tenNguoiDungcontroller.text ==
                                                        "" ||
                                                    emailcontroller.text ==
                                                        "" ||
                                                    diachicontroller.text ==
                                                        "" ||
                                                    imgcontroller.text == "" ||
                                                    sdtcontroller.text == "" ||
                                                    tuoicontroller.text == "" ||
                                                    int.tryParse(sdtcontroller
                                                            .text) ==
                                                        null) {
                                                  CherryToast.warning(
                                                          title: Text(
                                                              "Vui lòng kiểm tra thông tin nhập"))
                                                      .show(context);
                                                } else {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("Users")
                                                      .doc(snapshot.data!
                                                          .docs[index]['id'])
                                                      .update({
                                                    'tenNguoiDung':
                                                        tenNguoiDungcontroller
                                                            .text,
                                                    'diaChi':
                                                        diachicontroller.text,
                                                    'email':
                                                        emailcontroller.text,
                                                    'img': imgcontroller.text,
                                                    'sdt': int.parse(
                                                        sdtcontroller.text),
                                                    'tuoi': int.parse(
                                                        tuoicontroller.text)
                                                  });
                                                  CherryToast.success(
                                                          title: Text(
                                                              "Sửa thông tin người dùng thành công"))
                                                      .show(context);
                                                }
                                              }),
                                          TextButton(
                                              child: Text("Quay lại"),
                                              onPressed: () =>
                                                  Navigator.pop(context)),
                                        ],
                                      ).show(context);
                                    }),
                                TextButton(
                                    child: Text("Xóa"),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(snapshot.data!.docs[index]['id'])
                                          .delete();
                                      CherryToast.success(
                                              title: Text(
                                                  "Đã xóa người dùng thành công"))
                                          .show(context);
                                    }),
                                TextButton(
                                    child: Text("Quay lại"),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ).show(context);
                          },
                          title: Text(
                            "Email: ${snapshot.data!.docs[index]['email']}",
                            style: TextStyle(fontSize: 11),
                          ),
                          subtitle: Text(
                            "Tên: ${snapshot.data!.docs[index]['tenNguoiDung']}",
                          ),
                          trailing: Text(
                              "Quyền: ${snapshot.data!.docs[index]['vaitro']}"),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(191, 69, 157, 216),
                            borderRadius: BorderRadius.circular(15)),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
