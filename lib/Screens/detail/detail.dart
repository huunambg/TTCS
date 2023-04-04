import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/cherry_toast_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  int sl = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(219, 255, 255, 255),
      body: ListView(
        children: [
          Container(
            // khu vuc anh
            height: h * 0.4,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 231, 231),
                image: DecorationImage(
                  image: AssetImage("${widget.f['img']}"),
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
            height: 5,
          ),
          //phan thong tin san pham
          Container(
            height: h * 1.1,
            child: Column(
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
                      Text(
                        '${tienviet(widget.f['gia'] * 12 ~/ 10)}₫',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Color.fromARGB(245, 58, 57, 57),
                            fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
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
                                    color:
                                        Color.fromARGB(255, 223, 219, 219)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mô tả sản phẩm",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ReadMoreText(
                              '${widget.f['chitietSP']}.',
                              trimLines: 2,
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
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        height: h * 0.29,
                        width: w * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sản phẩm liên quan",
                              style: TextStyle(fontSize: 18, color: Colors.red),
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
                                                                      .docs[
                                                                  index])));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 233, 231, 231),
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: h * 0.15,
                                                    width: w * 0.3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                "${snapshot.data!.docs[index]['img']}"))),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                      height: h * 0.057,
                                                      width: w * 0.3,
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              "${snapshot.data!.docs[index]['tenSP']}"),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "Giá: ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13),
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
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: h * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đánh giá",
                              style: TextStyle(fontSize: 20),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: h * 0.08,
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 2, right: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(31, 160, 150, 150)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                          "assets/images/acount.png"),
                                    ),
                                    title: Text("Hữu Nam phản hồi"),
                                    subtitle: Text("Sản phẩm này rất tuyệt"),
                                    trailing: Icon(
                                        Ionicons.ellipsis_vertical_outline),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
