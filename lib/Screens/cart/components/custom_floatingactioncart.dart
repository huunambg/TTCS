import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class CusstomFloatingActionButtonCart extends StatefulWidget {
  const CusstomFloatingActionButtonCart(
      {super.key, required this.onpresedmuangay, required this.sum});

  final GestureTapCallback onpresedmuangay;
  final int sum;
  @override
  State<CusstomFloatingActionButtonCart> createState() =>
      _CusstomFloatingActionButtonCartState();
}

class _CusstomFloatingActionButtonCartState
    extends State<CusstomFloatingActionButtonCart> {
  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 234, 230, 230)))),
      child: Row(
        children: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tổng thanh toán: ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "${tienviet(widget.sum)}đ",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              height: 50,
              width: w * 0.6,
            ),
          ),
          InkWell(
            onTap: widget.onpresedmuangay,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Mua hàng",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              height: 50,
              width: w * 0.4,
              color: Color.fromARGB(255, 245, 69, 56),
            ),
          ),
        ],
      ),
    );
  }
}
