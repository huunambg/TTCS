import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';
import 'package:trangsuchuunam/Screens/admin/qldonhang.dart';
import 'package:trangsuchuunam/Screens/admin/qlnguoidung.dart';
import 'package:trangsuchuunam/Screens/admin/qlsanpham.dart';
import 'package:trangsuchuunam/Screens/admin/tkdoanhthu.dart';
import 'package:trangsuchuunam/Screens/admin/xulyphanhoi.dart';
import 'package:trangsuchuunam/Screens/home/user/homeuser.dart';
import 'package:trangsuchuunam/Screens/login/login.dart';
import 'package:trangsuchuunam/Screens/root.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 208, 227, 187),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 66, 171, 219),
          title: Text(
            "Admin",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Root()),
                );
              },
              icon: Icon(Icons.keyboard_return)),
        ),
        body: GridView(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 170,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            CustomItemHome(
              image: "assets/images/qlsanpham.png",
              text: "Quản lý sản phẩm",
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QLSanPham()));
              },
            ),
            CustomItemHome(
              image: "assets/images/tkdoanhthu.png",
              text: "Thống kê doanh thu",
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThongKeDoanhThu()));
              },
            ),
            CustomItemHome(
              image: "assets/images/qldonhang.png",
              text: 'Quản lý dơn hàng',
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QLDonHang()));
              },
            ),
            CustomItemHome(
              image: "assets/images/qlnguoidung.png",
              text: "Quản lý người dùng",
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QLNguoiDung()));
              },
            ),
            CustomItemHome(
              image: "assets/images/phanhoi.png",
              text: "Xử lý phản hồi",
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => XuLyPhanHoi()));
              },
            ),
            CustomItemHome(
              image: "assets/images/thoat.png",
              text: "Thoát",
              onpressed: () {
                NDialog(
                  dialogStyle: DialogStyle(titleDivider: true),
                  title: Text("Đăng Xuất"),
                  content: Text("Bạn có chắc chắn Đăng Xuất"),
                  actions: <Widget>[
                    TextButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        }),
                    TextButton(
                        child: Text("No"),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ).show(context);
              },
            )
          ],
        ));
  }
}

class CustomItemHome extends StatelessWidget {
  const CustomItemHome(
      {super.key,
      required this.image,
      required this.text,
      required this.onpressed});
  final String image;
  final String text;
  final GestureTapCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        elevation: 26,
        color: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onpressed,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset("$image"),
            ),
            Text('$text',
                style: TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)))
          ],
        ),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 219, 218, 218)]),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
