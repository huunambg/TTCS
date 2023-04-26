import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ThongKeDoanhThu extends StatefulWidget {
  const ThongKeDoanhThu({super.key});

  @override
  State<ThongKeDoanhThu> createState() => _ThongKeDoanhThuState();
}

class _ThongKeDoanhThuState extends State<ThongKeDoanhThu> {
  int doanhthu = 0;
  int tongsodonban = 0;
  int tongsodonhuy = 0;
  int tongsodoncho = 0;
  String? date;
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

  Future<num> getSlDonCho() async {
    num totalAmount = 0;

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Orders')
        .where('trangThaiOrder', isEqualTo: 0)
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
    getSlDonCho().then((value) {
      setState(() {
        tongsodoncho = int.parse(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê doanh thu'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  type: OmniDateTimePickerType.date,
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  lastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  is24HourMode: false,
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                  selectableDayPredicate: (dateTime) {
                    // Disable 25th Feb 2023
                    if (dateTime == DateTime(2023, 2, 25)) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                );
                if (dateTime != null) {
                  date = DateFormat('dd-MM-yyyy').format(dateTime!);
                }
              },
              icon: Icon(Icons.calendar_month))
        ],
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
              Text("Tổng số đơn chờ xác nhận:"),
              Text(
                "$tongsodoncho",
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
