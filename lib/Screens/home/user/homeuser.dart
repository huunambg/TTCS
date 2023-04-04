import 'dart:convert';
import 'dart:developer';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Screens/listProduct/listproduct.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/detail/detailseach.dart';
import 'package:trangsuchuunam/Screens/home/user/components/custom_banner.dart';
import 'package:trangsuchuunam/Screens/home/user/components/custom_homeappbar.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:trangsuchuunam/Widgets/cusstombutton.dart';
import 'package:trangsuchuunam/Widgets/custom_card.dart';
import 'package:trangsuchuunam/Widgets/custom_text.dart';
import 'package:intl/intl.dart';

List<SanPham> _listsp = [];

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final x = Services();
  final user = FirebaseAuth.instance.currentUser;
  void addSP() async {
    final String response =
        await rootBundle.loadString('assets/data/data.json');
    var data = jsonDecode(response);
    for (var item in data["SanPham"]) {
      SanPham o = new SanPham(
          tenSP: item['tenSP'],
          gia: int.parse(item['gia']),
          img: item['img'],
          chitietSP: item['chitietSP'],
          loaiSP: item['loaiSP']);
      x.addSP(o);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchdatabaselist();
    super.initState();
    //addSP();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 212, 212),
      appBar: CustomHomeAppBar(context),
      body: ListView(
        children: [
          CustomBanner(),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                "Danh Mục",
                style: TextStyle(color: Colors.red),
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.only(left: 12, right: 12, top: 5),
            height: h * 0.12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Customcard_danhmuc(
                  img: "assets/images/iconnhan.png",
                  text: "Nhẫn",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Nhan()));
                  },
                ),
                Customcard_danhmuc(
                  img: "assets/images/icondaychuyen.png",
                  text: "Dây chuyền",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DayChuyen()));
                  },
                ),
                Customcard_danhmuc(
                  img: "assets/images/iconkhuyentai.png",
                  text: "Khuyên tai",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KhuyenTai()));
                  },
                ),
                Customcard_danhmuc(
                  img: "assets/images/iconlactay.png",
                  text: "Lắc tay",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LacTay()));
                  },
                ),
                Customcard_danhmuc(
                  img: "assets/images/iconvongchan.png",
                  text: "Lắc chân",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LacChan()));
                  },
                ),
                Customcard_danhmuc(
                  img: "assets/images/iconchamcaitoc.png",
                  text: "Châm cài tóc",
                  onpressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChamCaiToc()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: h * 0.06,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Text(
              "DEAL Giá Tốt Cho Bạn Mới",
              style: TextStyle(color: Colors.red),
            ),
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
                return GridView.builder(
                    padding: EdgeInsets.all(3.5),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: h * 0.35,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          f: snapshot.data!.docs[index],
                                        )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Color.fromARGB(255, 201, 200, 197),
                                child: Center(
                                  child: Image.asset(
                                    "${snapshot.data!.docs[index]['img'].toString()}",
                                    fit: BoxFit.cover,
                                    height: h * 0.26,
                                    width: double.infinity - 2,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1))),
                                height: h * 0.09,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${snapshot.data!.docs[index]['tenSP']}",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${tienviet(snapshot.data!.docs[index]['gia'])}₫",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text("Đã bán 233",
                                            style: TextStyle(fontSize: 9))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }

  fetchdatabaselist() async {
    List items = [];
    dynamic _cart = await Services().getDataSanPham();
    if (_cart == null) {
      print('error');
    } else {
      items = _cart;
      items.forEach((element) {
        SanPham a = new SanPham(
            maSP: element['maSP'],
            tenSP: element['tenSP'],
            img: element['img'],
            gia: element['gia'],
            chitietSP: element['chitietSP'],
            loaiSP: element['loaiSP']);
        _listsp.add(a);
      });
    }
  }
}

String tienviet(int number) {
  final formatCurrency = new NumberFormat.currency(locale: "vi_VN", symbol: "");
  return formatCurrency.format(number);
}

class Timkiem extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_return));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SanPham> hh = [];
    for (var item in _listsp) {
      if (item.tenSP.toString().toLowerCase().contains(query.toLowerCase())) {
        hh.add(item);
      }
      ;
    }
    return ListView.builder(
        itemCount: hh.length,
        itemBuilder: ((context, index) {
          final result = hh[index];
          return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(95, 195, 190, 190)))),
            height: 65,
            child: ListTile(
              leading: Container(
                height: 65,
                width: 65,
                color: Color.fromARGB(255, 224, 216, 216),
                child: Image.asset(
                  '${result.img}',
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text("Tên: ${result.tenSP}"),
              subtitle: Row(
                children: [
                  Text("Giá: "),
                  Text(
                    "${result.gia}",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailSeach(
                              f: hh[index],
                            )));
              },
            ),
          );
        }));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
