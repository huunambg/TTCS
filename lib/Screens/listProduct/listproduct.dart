import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 212, 212),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromARGB(95, 195, 190, 190))),
          backgroundColor: Colors.red,
          title: Text(
            "Danh Mục",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: GridView(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 170,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DayChuyen()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/icondaychuyen.png"),
                    ),
                    Text('Dây chuyền',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 243, 241, 241),
                    Color.fromARGB(255, 242, 243, 242)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Nhan()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/iconnhan.png"),
                    ),
                    Text('Nhẫn',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 219, 218, 218)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KhuyenTai()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/iconkhuyentai.png"),
                    ),
                    Text('Khuyên tai',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 219, 218, 218)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LacTay()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/iconlactay.png"),
                    ),
                    Text('Lắc tay',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 219, 218, 218)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LacChan()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/iconvongchan.png"),
                    ),
                    Text('Lắc chân',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 219, 218, 218)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              child: MaterialButton(
                elevation: 26,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChamCaiToc()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/iconchamcaitoc.png"),
                    ),
                    Text('Châm cài tóc',
                        style: TextStyle(
                            fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color.fromARGB(255, 219, 218, 218)
                  ]),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ));
  }
}

class DayChuyen extends StatefulWidget {
  const DayChuyen({super.key});

  @override
  State<DayChuyen> createState() => _DayChuyenState();
}

class _DayChuyenState extends State<DayChuyen> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Dây chuyền"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Dây chuyền")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

class Nhan extends StatefulWidget {
  const Nhan({super.key});

  @override
  State<Nhan> createState() => _NhanState();
}

class _NhanState extends State<Nhan> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Nhẫn"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Nhẫn")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

class KhuyenTai extends StatefulWidget {
  const KhuyenTai({super.key});

  @override
  State<KhuyenTai> createState() => _KhuyenTaiState();
}

class _KhuyenTaiState extends State<KhuyenTai> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Khuyên tai"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Khuyên tai")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

class LacTay extends StatefulWidget {
  const LacTay({super.key});

  @override
  State<LacTay> createState() => _LacTayState();
}

class _LacTayState extends State<LacTay> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Lắc tay"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Lắc tay")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

class LacChan extends StatefulWidget {
  const LacChan({super.key});

  @override
  State<LacChan> createState() => _LacChanState();
}

class _LacChanState extends State<LacChan> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Lắc chân"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Lắc chân")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

class ChamCaiToc extends StatefulWidget {
  const ChamCaiToc({super.key});

  @override
  State<ChamCaiToc> createState() => _ChamCaiTocState();
}

class _ChamCaiTocState extends State<ChamCaiToc> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Châm cài tóc"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SanPham")
            .where('loaiSP', isEqualTo: "Châm cài tóc")
            .snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }

  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }
}
