import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:trangsuchuunam/Screens/admin/widgets/custom_widgets.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'widgets/trackoderadmin.dart';

class QLDonHang extends StatefulWidget {
  const QLDonHang({super.key});

  @override
  State<QLDonHang> createState() => _QLDonHangState();
}

class _QLDonHangState extends State<QLDonHang> {
  final user = FirebaseAuth.instance.currentUser;
  final trangThaiOrdercontroller = TextEditingController();
  final chiTietOrdercontroller = TextEditingController();
  int tt = 5;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý đơn hàng"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: [
                "Tất cả",
                "Chờ xác nhận",
                "Chờ lấy hàng",
                'Đang giao',
                'Đã giao',
                'Đã hủy'
              ],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Lọc đơn",
                  hintText: "country in menu mode",
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value == "Tất cả") {
                    tt = 5;
                  } else if (value == "Chờ xác nhận") {
                    tt = 0;
                  } else if (value == "Chờ lấy hàng") {
                    tt = 1;
                  } else if (value == "Đang giao") {
                    tt = 2;
                  } else if (value == "Đã giao") {
                    tt = 3;
                  } else if (value == "Đã hủy") {
                    tt = 4;
                  }
                });
              },
              selectedItem: "Tất cả",
            ),
          ),
          StreamBuilder(
            stream: tt == 5
                ? FirebaseFirestore.instance.collection("Orders").snapshots()
                : FirebaseFirestore.instance
                    .collection("Orders")
                    .where('trangThaiOrder', isEqualTo: tt)
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Loi hihi"),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 70,
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrackOrderAdmin(
                                        f: snapshot.data!.docs[index],
                                      )));
                        },
                        onTap: () {
                          NDialog(
                            dialogStyle: DialogStyle(titleDivider: true),
                            title: Text(
                                "Đơn: ${snapshot.data!.docs[index]['tenOrder']}"),
                            content: Text("Mời bạn chọn chức năng"),
                            actions: <Widget>[
                              TextButton(
                                  child: Text(
                                    "Hoàn thành",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    final x = await FirebaseFirestore.instance
                                        .collection("Orders");
                                    await x
                                        .doc(snapshot.data!.docs[index]
                                            ['maOrder'])
                                        .update({
                                      'trangThaiOrder': 3,
                                      'chiTietOrder': "Đã giao",
                                      'ngayNhan': DateTime.now().toString()
                                    });
                                    CherryToast.success(
                                            title:
                                                Text("Đã hoàn thành đơn hàng"))
                                        .show(context);
                                  }),
                              TextButton(
                                  child: Text(
                                    "Sửa TT",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    trangThaiOrdercontroller.text = snapshot
                                        .data!.docs[index]['trangThaiOrder']
                                        .toString();
                                    Navigator.pop(context);
                                    NDialog(
                                      dialogStyle:
                                          DialogStyle(titleDivider: true),
                                      title: Text(
                                          "Tên dơn: ${snapshot.data!.docs[index]['tenOrder']}"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: trangThaiOrdercontroller,
                                        decoration: InputDecoration(
                                            labelText: "Trạng thái order"),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Text(
                                              "Lưu",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              if (trangThaiOrdercontroller
                                                          .text ==
                                                      "" ||
                                                  int.tryParse(
                                                          trangThaiOrdercontroller
                                                              .text) ==
                                                      null) {
                                                CherryToast.error(
                                                        title: Text(
                                                            "Vui lòng kiểm tra dữ liệu trạng thái đơn phải là kiểu số"))
                                                    .show(context);
                                              } else {
                                                if (int.parse(
                                                            trangThaiOrdercontroller
                                                                .text) <=
                                                        4 &&
                                                    int.parse(
                                                            trangThaiOrdercontroller
                                                                .text) >=
                                                        0) {
                                                  int tt = int.parse(
                                                      trangThaiOrdercontroller
                                                          .text);
                                                  final x =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("Orders")
                                                          .doc(snapshot.data!
                                                                  .docs[index]
                                                              ['maOrder']);
                                                  if (tt == 0) {
                                                    await x.update({
                                                      'trangThaiOrder': int.parse(
                                                          trangThaiOrdercontroller
                                                              .text),
                                                      'chiTietOrder':
                                                          "Chờ xác nhận"
                                                    });
                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã cập nhật thông tin đơn hàng"))
                                                        .show(context);
                                                  } else if (tt == 1) {
                                                    await x.update({
                                                      'trangThaiOrder': int.parse(
                                                          trangThaiOrdercontroller
                                                              .text),
                                                      'chiTietOrder':
                                                          "Chờ lấy hàng"
                                                    });
                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã cập nhật thông tin đơn hàng"))
                                                        .show(context);
                                                  } else if (tt == 2) {
                                                    await x.update({
                                                      'trangThaiOrder': int.parse(
                                                          trangThaiOrdercontroller
                                                              .text),
                                                      'chiTietOrder':
                                                          "Đang giao"
                                                    });
                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã cập nhật thông tin đơn hàng"))
                                                        .show(context);
                                                  } else if (tt == 3) {
                                                    await x.update({
                                                      'trangThaiOrder': int.parse(
                                                          trangThaiOrdercontroller
                                                              .text),
                                                      'chiTietOrder': "Đã giao",
                                                      'ngayNhan': DateTime.now()
                                                          .toString()
                                                    });
                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã cập nhật thông tin đơn hàng"))
                                                        .show(context);
                                                  } else if (tt == 4) {
                                                    await x.update({
                                                      'trangThaiOrder': int.parse(
                                                          trangThaiOrdercontroller
                                                              .text),
                                                      'chiTietOrder': "Đã hủy"
                                                    });
                                                    Navigator.pop(context);
                                                    CherryToast.success(
                                                            title: Text(
                                                                "Đã cập nhật thông tin đơn hàng"))
                                                        .show(context);
                                                  }
                                                } else {
                                                  Navigator.pop(context);
                                                  CherryToast.error(
                                                          title: Text(
                                                              "Vui lòng kiểm tra dữ liệu trạng thái đơn chỉ từ 0 đến đến 4"))
                                                      .show(context);
                                                }
                                              }
                                            }),
                                        TextButton(
                                            child: Text(
                                              "Quay lại",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                      ],
                                    ).show(context);
                                  }),
                              TextButton(
                                  child: Text(
                                    "Quay lại",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ).show(context);
                        },
                        title: Text(
                          "Tên đơn hàng: ${snapshot.data!.docs[index]['tenOrder']}",
                          style: TextStyle(fontSize: 11),
                        ),
                        subtitle: Text(
                          "KH: ${snapshot.data!.docs[index]['tenKhachHang']}",
                        ),
                        trailing: Text(
                            "TT: ${snapshot.data!.docs[index]['chiTietOrder']}"),
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(191, 69, 157, 216),
                          borderRadius: BorderRadius.circular(15)),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }
}
