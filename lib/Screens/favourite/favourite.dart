import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Screens/detail/detail.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Services/services.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 195, 190, 190))),
        backgroundColor: Colors.red,
        title: Text("Yêu thích"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.uid)
              .collection("Favourites")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Loi "),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 247, 234, 234)))),
                      child: SizedBox(
                        height: h * 0.18,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          f: snapshot.data!.docs[index],
                                        )));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Color.fromARGB(255, 233, 231, 231),
                                child: Image.asset(
                                  "${snapshot.data!.docs[index]['img'].toString()}",
                                  height: h * 0.179,
                                  width: h * 0.179,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${snapshot.data!.docs[index]['tenSP'].toString()}"),
                                    SizedBox(
                                      height: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          NDialog(
                                            dialogStyle:
                                                DialogStyle(titleDivider: true),
                                            title: Lottie.asset(
                                              'assets/lottie/favour_heart.json',
                                            ),
                                            content: Text(
                                                "Bạn có muốn loại bỏ ${snapshot.data!.docs[index]['tenSP'].toString()} khỏi mục yêu thích"),
                                            actions: <Widget>[
                                              IconsButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                text: 'Quay lại',
                                                iconData: Icons.keyboard_return,
                                                color: Color.fromARGB(
                                                    255, 67, 154, 225),
                                                textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                iconColor: Colors.white,
                                              ),
                                              IconsButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  final x = Services();
                                                  x.deleteFavourite(user!.uid,
                                                      "${snapshot.data!.docs[index]['maSP'].toString()}");
                                                  CherryToast.success(
                                                          title: Text(
                                                              "Đã bỏ ${snapshot.data!.docs[index]['tenSP']} khỏi mục yêu thích "))
                                                      .show(context);
                                                },
                                                text: 'Xóa',
                                                iconData: Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 243, 33, 33),
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                iconColor: Colors.white,
                                              ),
                                            ],
                                          ).show(context);
                                        },
                                        icon: Icon(
                                          Ionicons.heart_outline,
                                          color: Colors.red,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${tienviet(snapshot.data!.docs[index]['gia'])}₫",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.red),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
