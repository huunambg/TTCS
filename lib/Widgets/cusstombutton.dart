import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomButtonLogin_Signup extends StatelessWidget {
  const CustomButtonLogin_Signup({super.key, required this.onpressed, this.text});
  final GestureTapCancelCallback onpressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 233, 196, 86),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.black45,
            width: 1.3,
          ),
        ),
        minimumSize: const Size(double.infinity, 45),
      ),
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20,
        ),
      ),
    );
  }
}
