import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Customcard_danhmuc extends StatefulWidget {
  const Customcard_danhmuc(
      {super.key,
      required this.img,
      required this.text,
      required this.onpressed});
  final String img;
  final String text;
  final GestureTapCallback onpressed;

  @override
  State<Customcard_danhmuc> createState() => _Customcard_danhmucState();
}

class _Customcard_danhmucState extends State<Customcard_danhmuc> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onLongPress: () async {},
        onTap: widget.onpressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.08,
              width: w * 0.16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Color.fromARGB(255, 206, 198, 198))),
              child: Center(
                child: Image.asset(
                  "${widget.img}",
                  height: 34,
                  width: 34,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "${widget.text}",
                style: TextStyle(fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
