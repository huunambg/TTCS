import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Models/cart.dart';
import 'package:trangsuchuunam/Models/order.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Screens/cart/components/custom_floatingactioncart.dart';
import 'package:trangsuchuunam/Screens/cart/components/customshowmodalbottombycart.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final tenmuacontroller = TextEditingController();
  final diachimuacontroller = TextEditingController();
  final sdtmuacontroller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
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

  List<Carts> _listcart = [];
  DateTime startDate = DateTime.now();
  int sum = 0;
  int sl = 0;
  @override
  void initState() {
    super.initState();
    getname();
    fetchdatabaselist();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 195, 190, 190))),
        backgroundColor: Colors.red,
        title: Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.uid)
              .collection("Carts")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Loi "),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 247, 234, 234)))),
                      margin: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: h * 0.18,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Color.fromARGB(255, 233, 231, 231),
                                child: snapshot.data!.docs[index]['img']
                                            .toString()
                                            .length <
                                        50
                                    ? Image.asset(
                                        "${snapshot.data!.docs[index]['img'].toString()}",
                                        height: h * 0.179,
                                        width: h * 0.179,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "${snapshot.data!.docs[index]['img'].toString()}",
                                        height: h * 0.179,
                                        width: h * 0.179,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${snapshot.data!.docs[index]['tenSP'].toString()}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "Size:${snapshot.data!.docs[index]['size'].toString()}"),
                                    Row(
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 197, 188, 188),
                                                    width: 1)),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () async {
                                                  int sl = snapshot
                                                      .data!.docs[index]['sl'];
                                                  int sumtemp = snapshot
                                                      .data!.docs[index]['sum'];
                                                  if (sl > 1) {
                                                    sumtemp -= int.parse(
                                                        snapshot.data!
                                                            .docs[index]['gia']
                                                            .toString());
                                                    sl--;
                                                    final docCart =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Users')
                                                            .doc(user?.uid)
                                                            .collection("Carts")
                                                            .doc(snapshot.data!
                                                                    .docs[index]
                                                                ['maSP'])
                                                            .update({
                                                      'sl': sl,
                                                      'sum': sumtemp
                                                    });

                                                    setState(() {
                                                      sum -= int.parse(snapshot
                                                          .data!
                                                          .docs[index]['gia']
                                                          .toString());
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                    Ionicons.remove_outline),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                            "${snapshot.data!.docs[index]['sl'].toString()}"),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 197, 188, 188),
                                                    width: 1)),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () {
                                                  int sl = snapshot
                                                      .data!.docs[index]['sl'];
                                                  int sumtemp = snapshot
                                                      .data!.docs[index]['sum'];

                                                  if (sl < 20) {
                                                    sl++;
                                                    sumtemp += int.parse(
                                                        snapshot.data!
                                                            .docs[index]['gia']
                                                            .toString());
                                                    setState(() {
                                                      final docCart =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(user?.uid)
                                                              .collection(
                                                                  "Carts")
                                                              .doc(snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]
                                                                  ['maSP'])
                                                              .update({
                                                        'sl': sl,
                                                        'sum': sumtemp
                                                      });

                                                      sum += int.parse(snapshot
                                                          .data!
                                                          .docs[index]['gia']
                                                          .toString());
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  Ionicons.add,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 11, left: 0, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // Dialogs.materialDialog(
                                          //   color: Colors.white,
                                          //   msg:
                                          //       'Bạn có muốn xóa khỏi giỏ hàng!',
                                          //   title:
                                          //       '${snapshot.data!.docs[index]['tenSP'].toString()}',
                                          //   lottieBuilder: Lottie.asset(
                                          //     'assets/lottie/delete.json',
                                          //     fit: BoxFit.contain,
                                          //   ),
                                          //   dialogWidth: kIsWeb ? 0.3 : null,
                                          //   context: context,
                                          //   actions: [
                                          //     IconsButton(
                                          //       onPressed: () {
                                          //         Navigator.pop(context);
                                          //       },
                                          //       text: 'Quay lại',
                                          //       iconData: Icons.keyboard_return,
                                          //       color: Color.fromARGB(
                                          //           255, 166, 206, 238),
                                          //       textStyle: TextStyle(
                                          //           color: Color.fromARGB(
                                          //               255, 255, 255, 255)),
                                          //       iconColor: Colors.white,
                                          //     ),
                                          //     IconsButton(
                                          //       onPressed: () {
                                          //         final x = Services();
                                          //         x.deleteCart(user!.uid,
                                          //             "${snapshot.data!.docs[index]['maSP'].toString()}");
                                          //         setState(() {
                                          //           setState(() {
                                          //             sum = 0;
                                          //             fetchdatabaselist();
                                          //           });
                                          //         });
                                          //         Navigator.pop(context);
                                          //         // int temp =
                                          //         //     snapshot.data!.docs[index]['maSP'] ;
                                          //         // FirebaseFirestore.instance
                                          //         //     .collection("SanPham")
                                          //         //     .doc(snapshot.data!.docs[index]['maSP'])
                                          //         //     .update({'sl': temp});
                                          //         CherryToast.success(
                                          //                 title: Text(
                                          //                     "Đã xóa ${snapshot.data!.docs[index]['tenSP']} khỏi giỏ hàng "))
                                          //             .show(context);
                                          //       },
                                          //       text: 'Xóa',
                                          //       iconData: Icons.delete,
                                          //       color: Color.fromARGB(
                                          //           255, 243, 33, 33),
                                          //       textStyle: TextStyle(
                                          //           color: Colors.white),
                                          //       iconColor: Colors.white,
                                          //     ),
                                          //   ],
                                          // );
                                          NDialog(
                                            dialogStyle:
                                                DialogStyle(titleDivider: true),
                                            title: Lottie.asset(
                                              'assets/lottie/delete.json',
                                            ),
                                            content: Text(
                                                "Bạn có muốn xóa ${snapshot.data!.docs[index]['tenSP'].toString()} khỏi giỏ hàng"),
                                            actions: <Widget>[
                                              IconsButton(
                                                onPressed: () {
                                                  final x = Services();
                                                  x.deleteCart(user!.uid,
                                                      "${snapshot.data!.docs[index]['maSP'].toString()}");
                                                  setState(() {
                                                    setState(() {
                                                      sum = 0;
                                                      fetchdatabaselist();
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                  // int temp =
                                                  //     snapshot.data!.docs[index]['maSP'] ;
                                                  // FirebaseFirestore.instance
                                                  //     .collection("SanPham")
                                                  //     .doc(snapshot.data!.docs[index]['maSP'])
                                                  //     .update({'sl': temp});
                                                  CherryToast.success(
                                                          title: Text(
                                                              "Đã xóa ${snapshot.data!.docs[index]['tenSP']} khỏi giỏ hàng "))
                                                      .show(context);
                                                },
                                                text: 'Xóa',
                                                iconData: Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 243, 33, 33),
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                iconColor: Colors.white,
                                              ),
                                              IconsButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Quay lại',
                                                iconData: Icons.keyboard_return,
                                                color: Color.fromARGB(
                                                    255, 62, 146, 214),
                                                textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                iconColor: Colors.white,
                                              ),
                                            ],
                                          ).show(context);
                                        },
                                        icon: Icon(
                                          Ionicons.close_outline,
                                          size: 25,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Giá: "),
                                        Text(
                                          "${tienviet(snapshot.data!.docs[index]['gia'])}₫",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CusstomFloatingActionButtonCart(
        sum: sum,
        onpresedmuangay: () async {
          CollectionReference collectionRef = FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.uid)
              .collection("Carts");
          QuerySnapshot querySnapshot = await collectionRef.get();
          int sl = querySnapshot.size;

          if (sl > 0) {
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
                                    color: Color.fromARGB(66, 218, 203, 203)))),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  icon: Icon(Ionicons.close_outline),
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
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                controller: tenmuacontroller,
                                decoration: InputDecoration(
                                    labelText: "Họ Tên",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                controller: diachimuacontroller,
                                decoration: InputDecoration(
                                    labelText: "Địa chỉ",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                controller: sdtmuacontroller,
                                decoration: InputDecoration(
                                    labelText: "Số điện thoại",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: w * 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Số lượng mặt hàng: ",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "${sl}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tổng thanh toán: ",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "${tienviet(sum)}đ",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
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
                                DateTime endDate =
                                    startDate.add(Duration(days: 3));
                                Services s = new Services();
                                Orders _order = Orders();
                                if (tenmuacontroller.text == "" ||
                                    diachimuacontroller.text == "" ||
                                    sdtmuacontroller == "" ||
                                    int.tryParse(sdtmuacontroller.text) ==
                                        null) {
                                  CherryToast.warning(
                                          title: Text(
                                              "Vui lòng kiểm tra thông tin"))
                                      .show(context);
                                } else {
                                  if (sdtmuacontroller.text.length < 9 ||
                                      sdtmuacontroller.text.length > 14) {
                                    CherryToast.warning(
                                            title: Text(
                                                "Số điện thoại phải lớn hơn 9 số và nhỏ hơn 14 số"))
                                        .show(context);
                                  } else {
                                    _order.tenKhachHang = tenmuacontroller.text;
                                    _order.diaChiOrder =
                                        diachimuacontroller.text;
                                    _order.sdt =
                                        int.parse(sdtmuacontroller.text);
                                    _listcart.forEach((item) {
                                      _order.tenOrder = item.tenSP;
                                      _order.size = item.size;
                                      _order.tongTien = item.sl! *
                                          int.parse(item.gia.toString());
                                      _order.ngayDuKien = endDate.toString();
                                      _order.ngayOrder = startDate.toString();
                                      _order.soLuong = item.sl;
                                      _order.gia = item.gia;
                                      _order.maNguoiDung = user?.uid;
                                      _order.image = item.img;
                                      _order.chiTietOrder = "Chờ xác nhận";
                                      _order.trangThaiOrder = 0;
                                      String? ma = item.maSP;
                                      s.deleteCart(user!.uid, ma!);
                                      //   s.addOrder(_order, user!.uid);
                                      s.addOO(_order);
                                    });

                                    Navigator.pop(context);
                                    CherryToast.success(
                                            title:
                                                Text("Đã đặt hàng thành công "))
                                        .show(context);
                                    setState(() {
                                      sum = 0;
                                    });
                                    _listcart = [];
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Đặt hàng",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                height: 50,
                                width: w * 0.4,
                                color: Color.fromARGB(255, 245, 69, 56),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]));
              },
            );
          } else {
            CherryToast.error(
                    title: Text("Vui lòng thêm sản phẩm vào giỏ hàng"))
                .show(context);
          }
        },
      ),
    );
  }

  fetchdatabaselist() async {
    List items = [];
    if (user != null) {
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
            size: element['size'],
          );

          _listcart.add(a);
          setState(() {
            sum += int.parse(element['gia'].toString()) *
                int.parse(element['sl'].toString());
          });
        });
      }
    }
  }
}
