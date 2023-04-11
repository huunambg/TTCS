import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/cherry_toast_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trangsuchuunam/Models/danhgia.dart';
import 'package:trangsuchuunam/Models/order.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Screens/detail/components/cusstom_showmodelbottom.dart';
import 'package:trangsuchuunam/Screens/detail/components/custom_chitietsp.dart';
import 'package:trangsuchuunam/Screens/detail/components/custom_flatingactionbutton.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/custom_text.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

// day la man hinh chi tiet
class Detail extends StatefulWidget {
  const Detail({super.key, required this.f});
  final f; // luu du lieu tu click
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final tenmuacontroller = TextEditingController();
  final sdtmuacontroller = TextEditingController();
  final danhgiacontroller = TextEditingController();
  String? img;
  DateTime startDate = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  void getname() {
    DocumentReference docRef =
        firestore.collection('Users').doc('${user?.uid}');
    docRef.get().then((doc) => {
          if (doc.exists)
            setState(() {
              tenmuacontroller.text = doc.get('tenNguoiDung');
              sdtmuacontroller.text = "0${doc.get('sdt').toString()}";
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
  }

  int sl = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFebeff2),
      body: ListView(
        children: [
          Container(
            // khu vuc anh
            height: h * 0.4,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 231, 231),
                image: widget.f['img'].toString().length < 50
                    ? DecorationImage(
                        image: AssetImage("${widget.f['img']}"),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage("${widget.f['img']}"),
                        fit: BoxFit.cover,
                      )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Ionicons.arrow_back_outline)),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Ionicons.ellipsis_vertical_outline)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          //phan thong tin san pham
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 5, left: 5),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.f['tenSP']}",
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: Icon(Ionicons.heart_outline, size: 30),
                          onPressed: () {
                            SanPham _sp = new SanPham();
                            final x = Services();
                            _sp.tenSP = widget.f['tenSP'];
                            _sp.chitietSP = widget.f['chitietSP'];
                            _sp.gia = widget.f['gia'];
                            _sp.loaiSP = widget.f['loaiSP'];
                            _sp.img = widget.f['img'];
                            _sp.maSP = widget.f['maSP'];
                            x.addFavourite(_sp, user!.uid);
                            CherryToast.success(
                                    title: Text(
                                        "Đã thêm ${widget.f['tenSP']} vào mục yêu thích "))
                                .show(context);
                          },
                        )
                      ],
                    ),
                    Text(
                      '${tienviet(widget.f['gia'])}₫',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${tienviet(widget.f['gia'] * 12 ~/ 10)}₫',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Color.fromARGB(245, 58, 57, 57),
                              fontSize: 11.5),
                        ),
                        Text(widget.f['sl'] != 0
                            ? "Kho: ${widget.f['sl']}"
                            : "Hết hàng")
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 6),
                      height: 30,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 13,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 13,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 13,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 13,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Ionicons.star_half_outline,
                                color: Colors.yellow,
                                size: 11.5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("4.8"),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Đã bán 6.5k")
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.share),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CustomChiTietSP(
                      onpressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CusstomItemshowModalBottomSheetChiTietSP(
                              images: "${widget.f['img']}",
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 223, 219, 219)),
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 223, 219, 219)))),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mô tả sản phẩm",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ReadMoreText(
                              '${widget.f['chitietSP']}.',
                              trimLines: 3,
                              preDataTextStyle:
                                  TextStyle(fontWeight: FontWeight.w500),
                              style: TextStyle(color: Colors.black),
                              colorClickableText:
                                  Color.fromARGB(255, 128, 157, 230),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Xem thêm',
                              trimExpandedText: 'Thu gọn',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      height: h * 0.3,
                      width: w * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sản phẩm liên quan",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: h * 0.23,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("SanPham")
                                  .where('loaiSP',
                                      isEqualTo: '${widget.f['loaiSP']}')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Loi hihi"),
                                  );
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Detail(
                                                            f: snapshot.data!
                                                                .docs[index])));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 233, 231, 231),
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            margin: EdgeInsets.only(right: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: h * 0.15,
                                                  width: w * 0.3,
                                                  decoration: BoxDecoration(
                                                      image: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ['img']
                                                                  .toString()
                                                                  .length <
                                                              50
                                                          ? DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  "${snapshot.data!.docs[index]['img']}"))
                                                          : DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  "${snapshot.data!.docs[index]['img']}"))),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    height: h * 0.057,
                                                    width: w * 0.3,
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${snapshot.data!.docs[index]['tenSP']}"),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Giá: ",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                                "${tienviet(snapshot.data!.docs[index]['gia'])}₫",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .red)),
                                                          ],
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            ],
          ),

          Container(
            padding: EdgeInsets.fromLTRB(3, 0, 3, h * 0.1),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.05,
                  width: double.infinity,
                  color: Colors.white,
                  child: Text(
                    "Đánh giá",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("DanhGia")
                      .where('maSP', isEqualTo: '${widget.f['maSP']}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Loi hihi"),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            height: h * 0.25,
                            margin: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(31, 160, 150, 150)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    img.toString().length > 50
                                        ? CircleAvatar(
                                            child: Image.network(
                                              "${snapshot.data!.docs[index]['img']}",
                                              height: 60,
                                              width: 60,
                                            ),
                                          )
                                        : CircleAvatar(
                                            child: Image.asset(
                                              "assets/images/acount.png",
                                              height: 60,
                                              width: 60,
                                            ),
                                          ),
                                    SizedBox(
                                      width: w * 0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${snapshot.data!.docs[index]['tenNguoiDung']}"),
                                        Text(
                                          "${DateFormat('dd-MM-yyyy KK:mm a').format(DateTime.parse(snapshot.data!.docs[index]['thoiGian'].toString()))}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 126, 123, 123)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height: h * 0.13,
                                  child: Text(
                                      "${snapshot.data!.docs[index]['noiDung']}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("5.0"),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextField(
                    controller: danhgiacontroller,
                    decoration: InputDecoration(
                        hintText: "Nhập nội dung dánh giá",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              if (danhgiacontroller.text == "" ||
                                  tenmuacontroller.text == "") {
                                CherryToast.warning(
                                        title: Text("Vui lòng không để trống!"))
                                    .show(context);
                              } else {
                                if (danhgiacontroller.text.length > 220) {
                                  CherryToast.warning(
                                          title: Text(
                                              "Nội dung đánh giá tối thiểu 220!"))
                                      .show(context);
                                } else {
                                  Services x = new Services();
                                  Danhgia _danhgia = new Danhgia();
                                  _danhgia.maSP = widget.f['maSP'];
                                  _danhgia.noiDung = danhgiacontroller.text;
                                  _danhgia.thoiGian = DateTime.now().toString();
                                  _danhgia.tenNguoiDung = tenmuacontroller.text;
                                  _danhgia.img = img;
                                  setState(() {
                                    danhgiacontroller.text = "";
                                  });
                                  await x.addDanhGia(_danhgia);
                                  CherryToast.success(
                                          title: Text(
                                              "Cảm ơn bạn đánh giá sản phẩm"))
                                      .show(context);
                                }
                              }
                            },
                            icon: Icon(Icons.send))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: CusstomFloatingActionButton(
        onpresedgiohang: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CusstomItemshowModalBottomSheetThanhToan_GioHang(
                images: "${widget.f['img']}",
                f: widget.f,
                user: user?.uid,
              );
            },
          );
        },
        onpresedmuangay: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CusstomItemshowModalBottomSheetMuaNgay(
                images: "${widget.f['img']}",
                f: widget.f,
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }
}
