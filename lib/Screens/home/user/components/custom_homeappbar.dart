import 'package:flutter/material.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';

AppBar CustomHomeAppBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Color.fromARGB(255, 182, 218, 230),
    backgroundColor: Colors.red,
    automaticallyImplyLeading: false,

    toolbarHeight: 80,
    title: Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.66,
              // form Seach store
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/kimcuong.png",
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Hữu Nam Jewelry")
                      ],
                    ),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Timkiem());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 27,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.notifications,
              color: Colors.white,
              size: 27,
            )
          ],
        ),
      ],
    ),
  );
}
