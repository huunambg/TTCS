import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trangsuchuunam/Models/cart.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'custom_flatingactionbutton.dart';

// day la ModalBottom
class CusstomItemshowModalBottomSheetThanhToan_GioHang extends StatefulWidget {
  const CusstomItemshowModalBottomSheetThanhToan_GioHang(
      {super.key, required this.images, this.f, this.user});
  final f;
  final user;
  final String images;
  @override
  State<CusstomItemshowModalBottomSheetThanhToan_GioHang> createState() =>
      _CusstomItemshowModalBottomSheetThanhToan_GioHangState();
}

class _CusstomItemshowModalBottomSheetThanhToan_GioHangState
    extends State<CusstomItemshowModalBottomSheetThanhToan_GioHang> {
  final user = FirebaseAuth.instance.currentUser;
  List<Carts> _listcart = [];

  int sl = 1;

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h * 0.56,
          child: Container(
              child: Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(66, 218, 203, 203)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Color.fromARGB(255, 223, 220, 220),
                    height: h * 0.167,
                    width: w * 0.29,
                    child: Image.asset("${widget.images}"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.close_outline),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: h * 0.34,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(66, 218, 203, 203)))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (sl > 1) {
                                sl--;
                              }
                            });
                          },
                          icon: Icon(Ionicons.remove_outline),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Color.fromARGB(255, 197, 188, 188),
                                  width: 1)),
                          child: Text("$sl"),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (sl < 20) {
                                sl++;
                              }
                            });
                          },
                          icon: Icon(
                            Ionicons.add,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: w * 0.8,
                      onPressed: () {
                        add();
                      },
                      color: Color.fromARGB(255, 133, 223, 235),
                      child: Text("Thêm vào giỏ hàng"),
                    ),
                  ],
                )),
          ])),
        )
      ],
    );
  }

  Future<void> add() async {
    var id = user?.uid;
    int temp = sl;
    int c = 0;
    for (int i = 0; i < _listcart.length; i++) {
      if (_listcart[i].tenSP == widget.f['tenSP']) {
        temp += int.parse(_listcart[i].sl.toString());
        final docCart = FirebaseFirestore.instance
            .collection('Users')
            .doc(id)
            .collection("Carts")
            .doc(_listcart[i].maSP)
            .update({'sl': temp});
        c++;
      }
    }
    if (c == 0) {
      Carts _sp = new Carts();
      final x = Services();
      _sp.tenSP = widget.f['tenSP'];
      _sp.chitietSP = widget.f['chitietSP'];
      _sp.gia = widget.f['gia'];
      _sp.loaiSP = widget.f['loaiSP'];
      _sp.img = widget.f['img'];
      _sp.sl = sl;
      _sp.sum = widget.f['gia'] * sl;
      x.addCart(_sp, widget.user.toString());
      Navigator.pop(context);
      CherryToast.success(
              title: Text(
                  "Đã thêm ${widget.f['tenSP']} số lượng $sl vào giỏ hàng "))
          .show(context);
    }
  }

  fetchdatabaselist() async {
    List items = [];
    dynamic _cart = await Services().getData(user!.uid);
    if (_cart == null) {
      print('error');
    } else {
      items = _cart;
      items.forEach((element) {
        Carts a = new Carts(
            maSP: element['maSP'],
            tenSP: element['tenSP'],
            img: element['img'],
            gia: element['gia'],
            chitietSP: element['chitietSP'],
            sl: element['sl']);
        _listcart.add(a);
      });
    }
  }
}

class CusstomItemshowModalBottomSheetThanhToan_GioHangSeach
    extends StatefulWidget {
  const CusstomItemshowModalBottomSheetThanhToan_GioHangSeach(
      {super.key, required this.images, required this.f, this.user});
  final SanPham f;
  final user;
  final String images;
  @override
  State<CusstomItemshowModalBottomSheetThanhToan_GioHangSeach> createState() =>
      _CusstomItemshowModalBottomSheetThanhToan_GioHangSeachState();
}

class _CusstomItemshowModalBottomSheetThanhToan_GioHangSeachState
    extends State<CusstomItemshowModalBottomSheetThanhToan_GioHangSeach> {
  final user = FirebaseAuth.instance.currentUser;
  List<Carts> _listcart = [];

  int sl = 1;

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h * 0.56,
          child: Container(
              child: Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(66, 218, 203, 203)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Color.fromARGB(255, 223, 220, 220),
                    height: h * 0.167,
                    width: w * 0.29,
                    child: Image.asset("${widget.images}"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.close_outline),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: h * 0.34,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(66, 218, 203, 203)))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (sl > 1) {
                                sl--;
                              }
                            });
                          },
                          icon: Icon(Ionicons.remove_outline),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Color.fromARGB(255, 197, 188, 188),
                                  width: 1)),
                          child: Text("$sl"),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (sl < 20) {
                                sl++;
                              }
                            });
                          },
                          icon: Icon(
                            Ionicons.add,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: w * 0.8,
                      onPressed: () {
                        add();
                      },
                      color: Color.fromARGB(255, 133, 223, 235),
                      child: Text("Thêm vào giỏ hàng"),
                    ),
                  ],
                )),
          ])),
        )
      ],
    );
  }

  Future<void> add() async {
    var id = user?.uid;
    int temp = sl;
    int c = 0;
    for (int i = 0; i < _listcart.length; i++) {
      if (_listcart[i].tenSP == widget.f.tenSP) {
        temp += int.parse(_listcart[i].sl.toString());
        final docCart = FirebaseFirestore.instance
            .collection('Users')
            .doc(id)
            .collection("Carts")
            .doc(_listcart[i].maSP)
            .update({'sl': temp});
        c++;
      }
    }
    if (c == 0) {
      Carts _sp = new Carts();
      final x = Services();
      _sp.tenSP = widget.f.tenSP;
      _sp.chitietSP = widget.f.chitietSP;
      _sp.gia = widget.f.gia;
      _sp.loaiSP = widget.f.loaiSP;
      _sp.img = widget.f.img;
      _sp.sl = sl;
      _sp.sum = int.parse(widget.f.gia.toString()) * sl;
      x.addCart(_sp, widget.user.toString());
      Navigator.pop(context);
      CherryToast.success(
              title:
                  Text("Đã thêm ${widget.f.tenSP} số lượng $sl vào giỏ hàng "))
          .show(context);
    }
  }

  fetchdatabaselist() async {
    List items = [];
    dynamic _cart = await Services().getData(user!.uid);
    if (_cart == null) {
      print('error');
    } else {
      items = _cart;
      items.forEach((element) {
        Carts a = new Carts(
            maSP: element['maSP'],
            tenSP: element['tenSP'],
            img: element['img'],
            gia: element['gia'],
            chitietSP: element['chitietSP'],
            sl: element['sl']);
        _listcart.add(a);
      });
    }
  }
}

class CusstomItemshowModalBottomSheetChiTietSP extends StatefulWidget {
  const CusstomItemshowModalBottomSheetChiTietSP(
      {super.key, required this.images});
  final String images;
  @override
  State<CusstomItemshowModalBottomSheetChiTietSP> createState() =>
      _CusstomItemshowModalBottomSheetChiTietState();
}

class _CusstomItemshowModalBottomSheetChiTietState
    extends State<CusstomItemshowModalBottomSheetChiTietSP> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h * 0.55,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(66, 218, 203, 203)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Color.fromARGB(255, 223, 220, 220),
                        height: h * 0.167,
                        width: w * 0.3,
                        child: Image.asset("${widget.images}"),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Ionicons.close_outline),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.35,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Trọng lượng tham khảo:"),
                            Text("64.28611gam")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Loại đá chính:"),
                            Text("Mother of Pearl")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Thương hiệu:"), Text("Ý")],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Thể loại:"), Text("Nhẫn")],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Giới tính:"), Text("nam,nữ")],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        height: h * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Bộ sưu tập:"), Text("ABC")],
                        ),
                      )
                    ],
                  ),
                ),
              ])),
        )
      ],
    );
  }
}
