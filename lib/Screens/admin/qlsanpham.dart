import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
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
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sản phẩm"),
        centerTitle: true,
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
                                      String img =
                                          snapshot.data!.docs[index]['img'];
                                      String loaiSP =
                                          snapshot.data!.docs[index]['loaiSP'];
                                      String maSP =
                                          snapshot.data!.docs[index]['maSP'];
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
                                            Row(
                                              children: [
                                                TextButton(
                                                    child: Text("Sửa"),
                                                    onPressed: () async {
                                                      print(snapshot.data!
                                                          .docs[index]['maSP']);
                                                      String img = snapshot
                                                          .data!
                                                          .docs[index]['img'];
                                                      String loaiSP = snapshot
                                                              .data!.docs[index]
                                                          ['loaiSP'];
                                                      ;
                                                      Navigator.pop(context);
                                                      FirebaseFirestore.instance
                                                          .collection("SanPham")
                                                          .doc(snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ['maSP']
                                                              .toString())
                                                          .update({
                                                        'tenSP': tenspcontroller
                                                            .text,
                                                        'loaiSP': loaiSP,
                                                        'gia': int.parse(
                                                            giacontroller.text
                                                                .toString())
                                                      });
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
                          subtitle: Text("Số lượng: 50",
                              style: TextStyle(color: Colors.white70)),
                          trailing: Text("Đã bán: 2"),
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
