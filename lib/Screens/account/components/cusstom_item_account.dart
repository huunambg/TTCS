import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CusstomItemAcount extends StatelessWidget {
  const CusstomItemAcount(
      {super.key, required this.text, this.onpressed, required this.iconn});
  final String text;
  final iconn;
  final GestureTapCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: h * 0.111,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(31, 110, 102, 102)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(iconn),
                SizedBox(
                  width: 15,
                ),
                Text("$text")
              ],
            ),
            Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
