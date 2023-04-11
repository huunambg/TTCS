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
import 'package:trangsuchuunam/Models/order.dart';
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
  List<String> _sizes = ['S', 'M', 'L', 'XL'];
  List<bool> _selectedSizes = [false, false, false, false];
  Color _getBorderColor(bool selected) {
    return selected ? Colors.green : Colors.grey;
  }

  String? size;
  int _selectedSizeIndex = -1;
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
                    child: widget.images.length < 50
                        ? Image.asset("${widget.images}")
                        : Image.network("${widget.images}"),
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
                    Wrap(
                      spacing: 10,
                      children:
                          List<Widget>.generate(_sizes.length, (int index) {
                        return ChoiceChip(
                          backgroundColor: Colors.white,
                          label: Text(_sizes[index]),
                          selected: _selectedSizeIndex == index,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedSizeIndex = index;
                                size = _sizes[index];
                                print(size);
                              } else {
                                _selectedSizeIndex = -1;
                                size = null;
                                print(size);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: _selectedSizeIndex == index
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
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
    if (size != null) {
      for (int i = 0; i < _listcart.length; i++) {
        if (_listcart[i].tenSP == widget.f['tenSP'] &&
            _listcart[i].size == size) {
          if (sl <= widget.f['sl']) {
            temp += int.parse(_listcart[i].sl.toString());
            final docCart = FirebaseFirestore.instance
                .collection('Users')
                .doc(id)
                .collection("Carts")
                .doc(_listcart[i].maSP)
                .update({'sl': temp});
            c++;
            Navigator.pop(context);
            CherryToast.success(
                    title: Text(
                        "Đã thêm ${widget.f['tenSP']} số lượng $sl vào giỏ hàng "))
                .show(context);
            int temp2 = widget.f['sl'] - sl;
            FirebaseFirestore.instance
                .collection("SanPham")
                .doc(widget.f['maSP'].toString())
                .update({'sl': temp2});
            size = null;
          } else {
            size = null;
            Navigator.pop(context);
            CherryToast.error(title: Text("Số lượng trong kho không dủ"))
                .show(context);
          }
        }
      } //for
      if (c == 0) {
        if (sl <= widget.f['sl']) {
          Carts _sp = new Carts();
          final x = Services();
          _sp.size = size;
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
          int temp = widget.f['sl'] - sl;
          FirebaseFirestore.instance
              .collection("SanPham")
              .doc(widget.f['maSP'].toString())
              .update({'sl': temp});
        } else {
          Navigator.pop(context);
          CherryToast.error(title: Text("Số lượng trong kho không dủ"))
              .show(context);
        }
        size = null;
      } //
    } else {
      CherryToast.error(title: Text("Vui lòng chọn size")).show(context);
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
            sl: element['sl'],
            size: element['size']);

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
                        child: widget.images.length < 50
                            ? Image.asset("${widget.images}")
                            : Image.network("${widget.images}"),
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

class CusstomItemshowModalBottomSheetMuaNgay extends StatefulWidget {
  const CusstomItemshowModalBottomSheetMuaNgay(
      {super.key, required this.images, this.f, this.user});
  final f;
  final user;
  final String images;
  @override
  State<CusstomItemshowModalBottomSheetMuaNgay> createState() =>
      _CusstomItemshowModalBottomSheetMuaNgayState();
}

class _CusstomItemshowModalBottomSheetMuaNgayState
    extends State<CusstomItemshowModalBottomSheetMuaNgay> {
  final tenmuacontroller = TextEditingController();
  final diachimuacontroller = TextEditingController();
  final sdtmuacontroller = TextEditingController();
  DateTime startDate = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getname() {
    DocumentReference docRef =
        firestore.collection('Users').doc('${user?.uid}');
    docRef.get().then((doc) => {
          if (doc.exists)
            setState(() {
              tenmuacontroller.text = doc.get('tenNguoiDung');
              diachimuacontroller.text = doc.get('diaChi');
              sdtmuacontroller.text = "0${doc.get('sdt').toString()}";
            })
        });
    ;
  }

  final user = FirebaseAuth.instance.currentUser;
  List<String> _sizes = ['S', 'M', 'L', 'XL'];
  List<bool> _selectedSizes = [false, false, false, false];
  Color _getBorderColor(bool selected) {
    return selected ? Colors.green : Colors.grey;
  }

  String? size;
  int _selectedSizeIndex = -1;

  int sl = 1;
  num sum = 0;
  @override
  void initState() {
    super.initState();
    getname();
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
                    child: widget.images.length < 50
                        ? Image.asset("${widget.images}")
                        : Image.network("${widget.images}"),
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
                    Wrap(
                      spacing: 10,
                      children:
                          List<Widget>.generate(_sizes.length, (int index) {
                        return ChoiceChip(
                          backgroundColor: Colors.white,
                          label: Text(_sizes[index]),
                          selected: _selectedSizeIndex == index,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedSizeIndex = index;
                                size = _sizes[index];
                                print(size);
                              } else {
                                _selectedSizeIndex = -1;
                                size = null;
                                print(size);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: _selectedSizeIndex == index
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
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
                        sum = sl * widget.f['gia'];
                        if (size != null) {
                          if (widget.f['sl'] != 0) {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: h * 0.56,
                                    width: w * 1,
                                    child: Column(children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: h * 0.06,
                                        width: w * 1,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        66, 218, 203, 203)))),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Thanh Toán",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Container(
                                                // height: 0.06,
                                                // width: 0.2,
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                      Ionicons.close_outline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: h * 0.36,
                                        width: w * 1,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextField(
                                                controller: tenmuacontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Họ Tên",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextField(
                                                controller: diachimuacontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Địa chỉ",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextField(
                                                controller: sdtmuacontroller,
                                                decoration: InputDecoration(
                                                    labelText: "Số điện thoại",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: w * 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Số lượng mặt hàng: ",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        "$sl",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Tổng thanh toán: ",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        "${tienviet(int.parse(sum.toString()))}đ",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              height: 50,
                                              width: w * 0.6,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                DateTime endDate = startDate
                                                    .add(Duration(days: 3));
                                                Services s = new Services();
                                                Orders _order = Orders();
                                                if (tenmuacontroller.text ==
                                                        "" ||
                                                    diachimuacontroller.text ==
                                                        "" ||
                                                    sdtmuacontroller == "" ||
                                                    int.tryParse(
                                                            sdtmuacontroller
                                                                .text) ==
                                                        null) {
                                                  CherryToast.warning(
                                                          title: Text(
                                                              "Vui lòng kiểm tra thông tin"))
                                                      .show(context);
                                                } else {
                                                  if (sdtmuacontroller
                                                              .text.length <
                                                          9 ||
                                                      sdtmuacontroller
                                                              .text.length >
                                                          14) {
                                                    CherryToast.warning(
                                                            title: Text(
                                                                "Số điện thoại phải lớn hơn 9 số và nhỏ hơn 14 số"))
                                                        .show(context);
                                                  } else {
                                                    _order.tenKhachHang =
                                                        tenmuacontroller.text;
                                                    _order.diaChiOrder =
                                                        diachimuacontroller
                                                            .text;
                                                    _order.sdt = int.parse(
                                                        sdtmuacontroller.text);

                                                    _order.tenOrder =
                                                        widget.f['tenSP'];
                                                    _order.size = size;
                                                    _order.tongTien = sl *
                                                        int.parse(widget
                                                            .f['gia']
                                                            .toString());
                                                    _order.ngayDuKien =
                                                        endDate.toString();
                                                    _order.ngayOrder =
                                                        startDate.toString();
                                                    _order.soLuong = sl;
                                                    _order.gia =
                                                        widget.f['gia'];
                                                    _order.maNguoiDung =
                                                        user?.uid;
                                                    _order.image =
                                                        widget.f['img'];
                                                    _order.chiTietOrder =
                                                        "Chờ xác nhận";
                                                    _order.trangThaiOrder = 0;
                                                    s.addOO(_order);

                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã đặt hàng thành công "))
                                                        .show(context);
                                                  }
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Đặt hàng",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                height: 50,
                                                width: w * 0.4,
                                                color: Color.fromARGB(
                                                    255, 245, 69, 56),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          } else {
                            CherryToast.warning(
                                    title: Text(
                                        'Số lượng hàng trong kho không đủ'))
                                .show(context);
                          }
                        } else {
                          CherryToast.warning(title: Text('Vui lòng chọn size'))
                              .show(context);
                        }
                      },
                      color: Color.fromARGB(255, 133, 223, 235),
                      child: Text("Mua ngay"),
                    ),
                  ],
                )),
          ])),
        )
      ],
    );
  }

  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }
}
