import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width * 0.66,
              // form Seach store
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      child: Lottie.asset('assets/lottie/dimond.json',
                          height: 40)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Hữu Nam SCJ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 70, 67, 67),
                        fontWeight: FontWeight.bold),
                  )
                ],
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
