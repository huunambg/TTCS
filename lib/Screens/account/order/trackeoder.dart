import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Services/services.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key, this.f});
  final f;
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final user = FirebaseAuth.instance.currentUser;
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 195, 190, 190))),
        backgroundColor: Colors.red,
        title: Text("Thông tin đơn hàng"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          EasyStepper(
            activeStep: widget.f["trangThaiOrder"],
            lineLength: 70,
            stepShape: StepShape.rRectangle,
            stepBorderRadius: 15,
            borderThickness: 2,
            padding: 20,
            stepRadius: 28,
            finishedStepBorderColor: Colors.blue,
            finishedStepTextColor: Colors.deepOrange,
            finishedStepBackgroundColor: Color.fromARGB(255, 20, 143, 231),
            activeStepIconColor: Colors.deepOrange,
            loadingAnimation: 'assets/lottie/shipping.json',
            steps: const [
              EasyStep(
                icon: Icon(Icons.add_task_rounded),
                title: 'Chờ xác nhận',
              ),
              EasyStep(
                icon: Icon(Icons.category_rounded),
                title: 'Chờ lấy hàng',
              ),
              EasyStep(
                icon: Icon(Icons.local_shipping_rounded),
                title: 'Đang giao',
              ),
              EasyStep(
                icon: Icon(Icons.door_back_door_outlined),
                title: 'Đã giao',
              ),
              EasyStep(
                icon: Icon(Icons.delete_forever),
                title: 'Đã hủy',
              ),
            ],
            onStepReached: (index) => setState(() => activeStep = index),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 247, 234, 234)))),
            child: SizedBox(
              height: h * 0.18,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackOrder(
                                f: widget.f,
                              )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 233, 231, 231),
                      child: widget.f['image'].toString().length < 50
                          ? Image.asset(
                              "${widget.f['image'].toString()}",
                              height: h * 0.179,
                              width: h * 0.179,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              "${widget.f['image'].toString()}",
                              height: h * 0.179,
                              width: h * 0.179,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Tên sản phẩm: ${widget.f['tenOrder'].toString()}"),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text("Size: ${widget.f['size'].toString()}"),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Số lượng: "),
                              Text(
                                "${widget.f['soLuong'].toString()}",
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Giá:",
                                  ),
                                  Text(
                                    "${tienviet(widget.f['gia'])}₫",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: h * 0.4,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Họ tên: ", style: TextStyle(fontSize: 17)),
                    Text(
                      "${widget.f["tenKhachHang"]}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 54, 149, 244)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Số điện thoại: ", style: TextStyle(fontSize: 17)),
                    Text(
                      "0${widget.f["sdt"]}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 54, 98, 244)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Địa chỉ: ", style: TextStyle(fontSize: 17)),
                    Text(
                      "${widget.f["diaChiOrder"]}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 54, 127, 244)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Ngày Order: ", style: TextStyle(fontSize: 17)),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.f['ngayOrder']))}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 54, 139, 244)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Ngày nhận hàng dự kiến: ",
                        style: TextStyle(fontSize: 17)),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.f['ngayDuKien']))}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 54, 152, 244)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Trạng thái: ", style: TextStyle(fontSize: 17)),
                    Text(
                      "${widget.f['chiTietOrder'].toString()}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 54, 158, 244),
                          fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Ngày nhận ", style: TextStyle(fontSize: 17)),
                    widget.f['ngayNhan'] != "chưa nhận"
                        ? Text(
                            "${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.f['ngayNhan']))}",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 54, 152, 244)),
                          )
                        : Text(
                            "${widget.f['ngayNhan']}",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 54, 152, 244)),
                          ),
                  ],
                ),
                Row(
                  children: [
                    Text("Tổng Tiền:", style: TextStyle(fontSize: 17)),
                    Text(
                      "${tienviet(widget.f['tongTien'])}₫",
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: h * 0.05,
          // ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: h * 0.06,
            width: w * 0.7,
            child: widget.f["trangThaiOrder"] != 4 &&
                    widget.f["trangThaiOrder"] != 3
                ? MaterialButton(
                    height: h * 0.06,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.red,
                    onPressed: () {
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Lottie.asset(
                          'assets/lottie/delete.json',
                        ),
                        content: Text("Bạn có muốn hủy đơn hàng"),
                        actions: <Widget>[
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Quay lại',
                            iconData: Icons.keyboard_return,
                            color: Color.fromARGB(255, 67, 154, 225),
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            iconColor: Colors.white,
                          ),
                          IconsButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await FirebaseFirestore.instance
                                  .collection("Orders")
                                  .doc(widget.f['maOrder'])
                                  .update({
                                'trangThaiOrder': 4,
                                'chiTietOrder': "đã hủy"
                              });
                              setState(() {});
                            },
                            text: 'Hủy',
                            iconData: Icons.delete,
                            color: Color.fromARGB(255, 243, 33, 33),
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      ).show(context);
                    },
                    child: Text(
                      "Hủy Đơn Hàng",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : null,
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
