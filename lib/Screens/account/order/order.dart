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
import 'package:trangsuchuunam/Screens/account/order/trackeoder.dart';
import 'package:trangsuchuunam/Services/services.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 195, 190, 190))),
        backgroundColor: Colors.red,
        title: Text("Đơn Mua"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.uid)
              .collection("Orders")
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
                                    builder: (context) => TrackOrder(
                                          f: snapshot.data!.docs[index],
                                        )));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Color.fromARGB(255, 233, 231, 231),
                                child: Image.asset(
                                  "${snapshot.data!.docs[index]['image'].toString()}",
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
                                        "${snapshot.data!.docs[index]['tenOrder'].toString()}"),
                                    Row(
                                      children: [
                                        Text("Trạng thái: "),
                                        Text(
                                          "${snapshot.data!.docs[index]['chiTietOrder'].toString()}",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Số lượng: "),
                                        Text(
                                          "${snapshot.data!.docs[index]['soLuong'].toString()}",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Tổng:",
                                            ),
                                            Text(
                                              "${tienviet(snapshot.data!.docs[index]['tongTien'])}₫",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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

  String tienviet(int number) {
    final formatCurrency =
        new NumberFormat.currency(locale: "vi_VN", symbol: "");
    return formatCurrency.format(number);
  }
}
