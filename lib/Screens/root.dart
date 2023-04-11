import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trangsuchuunam/Screens/listProduct/listproduct.dart';
import 'package:trangsuchuunam/Screens/account/acount.dart';
import 'package:trangsuchuunam/Screens/cart/cart.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'favourite/favourite.dart';

class Root extends StatefulWidget {
  const Root({super.key});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // danh sach cac man hinh(tabs)
  final tabs = [HomeUser(), ListProduct(), Cart(), Favourite(), Acount()];
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: (value) {
          setState(() {
            _currentindex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline), label: "Trang chủ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp),
            label: "Danh mục",
          ),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.bag_check_outline), label: "Giỏ hàng"),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.heart_outline), label: "Yêu thích"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Tài khoản"),
        ],
      ),
    );
  }
}
