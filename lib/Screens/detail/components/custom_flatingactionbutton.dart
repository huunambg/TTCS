import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// floattingacction button
class CusstomFloatingActionButton extends StatefulWidget {
  const CusstomFloatingActionButton({
    super.key,
    required this.onpresedgiohang,
    required this.onpresedmuangay,
  });
  final GestureTapCallback onpresedgiohang;
  final GestureTapCallback onpresedmuangay;

  @override
  State<CusstomFloatingActionButton> createState() =>
      _CusstomFloatingActionButtonState();
}

class _CusstomFloatingActionButtonState
    extends State<CusstomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        InkWell(
          onTap: widget.onpresedgiohang,
          child: Container(
            child: Icon(
              Ionicons.cart_outline,
              color: Colors.white,
            ),
            color: Color.fromARGB(255, 78, 181, 131),
            height: 50,
            width: w * 0.5,
          ),
        ),
        InkWell(
          onTap: widget.onpresedmuangay,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Mua ngay",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            height: 50,
            width: w * 0.5,
          ),
        ),
      ],
    );
  }
}
