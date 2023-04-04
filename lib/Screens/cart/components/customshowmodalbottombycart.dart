// day la ModalBottom
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Services/services.dart';

class CusstomItemshowModalBottomSheetMuaHang extends StatefulWidget {
  const CusstomItemshowModalBottomSheetMuaHang({super.key});

  // final user;
  @override
  State<CusstomItemshowModalBottomSheetMuaHang> createState() =>
      _CusstomItemshowModalBottomSheetMuaHangState();
}

class _CusstomItemshowModalBottomSheetMuaHangState
    extends State<CusstomItemshowModalBottomSheetMuaHang> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.56,
      width: w * 1,
      child: Container(
          child: Column(children: [
        Container(
          alignment: Alignment.center,
          height: h * 0.06,
          width: w * 1,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(66, 218, 203, 203)))),
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
          height: h * 0.4,
          width: w * 1,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Nhập Họ Tên",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Nhập địa chỉ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Nhập số điện thoại",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: w * 1,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Số lượng mặt hàng: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tổng thanh toán: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "0đ",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    ),
                  ],
                ),
                height: 50,
                width: w * 0.6,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Đặt hàng",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  height: 50,
                  width: w * 0.4,
                  color: Color.fromARGB(255, 245, 69, 56),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
