import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';

class QLSanPham extends StatefulWidget {
  const QLSanPham({super.key});

  @override
  State<QLSanPham> createState() => _QLSanPhamState();
}

class _QLSanPhamState extends State<QLSanPham> {
  final user = FirebaseAuth.instance.currentUser;
  final tenspcontroller = TextEditingController();
  final slcontroller = TextEditingController();
  final giacontroller = TextEditingController();
  final chitietcontroller = TextEditingController();
  final imgcontroller = TextEditingController();
  final loaispcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sản phẩm"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                tenspcontroller.text = "";
                giacontroller.text = "";
                chitietcontroller.text = "";
                loaispcontroller.text = "";
                imgcontroller.text = "";
                slcontroller.text = "";
                NDialog(
                    dialogStyle: DialogStyle(titleDivider: true),
                    title: Text("Thêm Sản phẩm"),
                    actions: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: tenspcontroller,
                          decoration: InputDecoration(
                              labelText: "Tên SP",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: slcontroller,
                          decoration: InputDecoration(
                              labelText: "SL",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: giacontroller,
                          decoration: InputDecoration(
                              labelText: "Giá",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: chitietcontroller,
                          decoration: InputDecoration(
                              labelText: "Chi Tiết",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: loaispcontroller,
                          decoration: InputDecoration(
                              labelText: "Loại sản phẩm",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: imgcontroller,
                          decoration: InputDecoration(
                              labelText: "Ảnh",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                              child: Text("Thêm"),
                              onPressed: () async {
                                if (loaispcontroller.text == "" ||
                                    slcontroller.text == "" ||
                                    tenspcontroller.text == "" ||
                                    giacontroller.text == "" ||
                                    imgcontroller.text == "" ||
                                    chitietcontroller.text == "" ||
                                    int.tryParse(slcontroller.text) == null ||
                                    int.tryParse(giacontroller.text) == null) {
                                  CherryToast.warning(
                                          title:
                                              Text("Vui lòng kiểm tra dữ liệu"))
                                      .show(context);
                                } else {
                                  Services x = new Services();
                                  SanPham sp = new SanPham();
                                  sp.tenSP = tenspcontroller.text;
                                  sp.chitietSP = chitietcontroller.text;
                                  sp.gia = int.parse(giacontroller.text);
                                  sp.sl = int.parse(slcontroller.text);
                                  sp.loaiSP = loaispcontroller.text;
                                  sp.img = imgcontroller.text;

                                  Navigator.pop(context);
                                  await x.addSP(sp);
                                  CherryToast.success(
                                          title:
                                              Text("Thêm sản phẩm thành công"))
                                      .show(context);
                                }
                              }),
                          TextButton(
                              child: Text("Quay lại"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    ]).show(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("SanPham").snapshots(),
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
                                  "${snapshot.data!.docs[index]['tenSP']}"),
                              content: Text("Mời bạn chọn chức năng"),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("Sửa"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      tenspcontroller.text =
                                          snapshot.data!.docs[index]['tenSP'];
                                      giacontroller.text = snapshot
                                          .data!.docs[index]['gia']
                                          .toString();
                                      chitietcontroller.text = snapshot
                                          .data!.docs[index]['chitietSP'];
                                      loaispcontroller.text =
                                          snapshot.data!.docs[index]['loaiSP'];
                                      imgcontroller.text =
                                          snapshot.data!.docs[index]['img'];
                                      slcontroller.text = snapshot
                                          .data!.docs[index]['sl']
                                          .toString();
                                      NDialog(
                                          dialogStyle:
                                              DialogStyle(titleDivider: true),
                                          title: Text(
                                              "Sửa: ${snapshot.data!.docs[index]['tenSP']}"),
                                          actions: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: tenspcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Tên SP",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: slcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "SL",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: giacontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Giá",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: chitietcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Chi Tiết",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: loaispcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Loại sản phẩm",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: TextFormField(
                                                controller: imgcontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Ảnh",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    child: Text("Sửa"),
                                                    onPressed: () async {
                                                      if (loaispcontroller
                                                                  .text ==
                                                              "" ||
                                                          slcontroller
                                                                  .text ==
                                                              "" ||
                                                          tenspcontroller.text ==
                                                              "" ||
                                                          giacontroller
                                                                  .text ==
                                                              "" ||
                                                          imgcontroller
                                                                  .text ==
                                                              "" ||
                                                          chitietcontroller
                                                                  .text ==
                                                              "" ||
                                                          int.tryParse(
                                                                  slcontroller
                                                                      .text) ==
                                                              null ||
                                                          int.tryParse(
                                                                  giacontroller
                                                                      .text) ==
                                                              null) {
                                                        CherryToast.warning(
                                                                title: Text(
                                                                    "Vui lòng kiểm tra dữ liệu"))
                                                            .show(context);
                                                      } else {
                                                        String img = snapshot
                                                            .data!
                                                            .docs[index]['img'];
                                                        String loaiSP = snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['loaiSP'];
                                                        ;
                                                        Navigator.pop(context);
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "SanPham")
                                                            .doc(snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ['maSP']
                                                                .toString())
                                                            .update({
                                                          'tenSP':
                                                              tenspcontroller
                                                                  .text,
                                                          'loaiSP': loaiSP,
                                                          'gia': int.parse(
                                                              giacontroller.text
                                                                  .toString()),
                                                          'img': imgcontroller
                                                              .text,
                                                          'sl': int.parse(
                                                              slcontroller
                                                                  .text),
                                                          'chitietSP':
                                                              chitietcontroller
                                                                  .text
                                                        });
                                                        CherryToast.success(
                                                                title: Text(
                                                                    "Sửa thông tin sản phẩm thành công"))
                                                            .show(context);
                                                      }
                                                    }),
                                                TextButton(
                                                    child: Text("Quay lại"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                              ],
                                            )
                                          ]).show(context);
                                    }),
                                TextButton(
                                    child: Text("Xóa"),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("SanPham")
                                          .doc(snapshot
                                              .data!.docs[index]['maSP']
                                              .toString())
                                          .delete();

                                      Navigator.pop(context);
                                    }),
                              ],
                            ).show(context);
                          },
                          title: Text(
                            "${snapshot.data!.docs[index]['tenSP']}",
                            style: TextStyle(fontSize: 11),
                          ),
                          subtitle: Text(
                              "Số lượng: ${snapshot.data!.docs[index]['sl']}",
                              style: TextStyle(color: Colors.white70)),
                          trailing: Text(
                              "Đã bán: ${50 - snapshot.data!.docs[index]['sl']}"),
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
