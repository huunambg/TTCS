import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class ThongKeDoanhThu extends StatefulWidget {
  const ThongKeDoanhThu({super.key});

  @override
  State<ThongKeDoanhThu> createState() => _ThongKeDoanhThuState();
}

class _ThongKeDoanhThuState extends State<ThongKeDoanhThu> {
  int doanhthu = 0;
  int tongsodonban = 0;
  int tongsodonhuy = 0;
  Future<num> getDoanhThu() async {
    num totalAmount = 0;

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Orders')
        .where('trangThaiOrder', isEqualTo: 3)
        .get();

    snapshot.docs.forEach((doc) {
      totalAmount += doc.get('tongTien');
    });

    return totalAmount;
  }

  Future<num> getSlDonban() async {
    num totalAmount = 0;

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Orders')
        .where('trangThaiOrder', isEqualTo: 3)
        .get();

    snapshot.docs.forEach((doc) {
      totalAmount++;
    });

    return totalAmount;
  }

  Future<num> getSlDonHuy() async {
    num totalAmount = 0;

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Orders')
        .where('trangThaiOrder', isEqualTo: 4)
        .get();

    snapshot.docs.forEach((doc) {
      totalAmount++;
    });

    return totalAmount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoanhThu().then((value) {
      setState(() {
        doanhthu = int.parse(value.toString());
      });
    });
    getSlDonban().then((value) {
      setState(() {
        tongsodonban = int.parse(value.toString());
      });
    });
    getSlDonHuy().then((value) {
      setState(() {
        tongsodonhuy = int.parse(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê doanh thu'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Doanh thu:"),
              Text(
                "  ${tienviet(doanhthu)}đ",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tổng số đơn bán:"),
              Text(
                "$tongsodonban",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tổng số đơn hủy:"),
              Text(
                "$tongsodonhuy",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
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
