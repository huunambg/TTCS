import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class CustomTextH1 extends StatelessWidget {
  const CustomTextH1({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }
}
