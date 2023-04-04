import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trangsuchuunam/Models/cart.dart';
import 'package:trangsuchuunam/Models/phanhoi.dart';
import 'package:trangsuchuunam/Models/product.dart';
import 'package:trangsuchuunam/Models/user.dart';
import 'package:trangsuchuunam/Models/order.dart';

class Services {
  Future addUsers(Users user, String id) async {
    final docUsers = FirebaseFirestore.instance.collection('Users');
    user.id = id;
    await docUsers.doc(id).set(user.toJson());
  }

  Future addSP(SanPham sp) async {
    final docSP = FirebaseFirestore.instance.collection("SanPham").doc();
    sp.maSP = docSP.id;
    await docSP.set(sp.toJson());
  }

  Future addFavourite(SanPham sp, String id) async {
    final docsfavourite = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Favourites");

    docsfavourite.doc(sp.maSP).get().then((doc) async => {
          if (doc.exists)
            {print("đã tồn tại")}
          else
            await docsfavourite.doc(sp.maSP).set(sp.toJson())
        });
  }

  Future addCart(Carts sp, String id) async {
    final docUsers = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Carts")
        .doc();
    sp.maSP = docUsers.id;
    await docUsers.set(sp.toJson());
  }

  Future deleteCart(String id, String idcart) async {
    final docCart = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Carts")
        .doc(idcart);
    await docCart.delete();
  }

  Future deleteFavourite(String id, String idcart) async {
    final docFavourite = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Favourites")
        .doc(idcart);
    await docFavourite.delete();
  }

////// ngawn cach
  ///
  Future addOrder(Orders sp, String id) async {
    final docOders = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Orders")
        .doc();
    sp.maOrder = docOders.id;
    await docOders.set(sp.toJson());
  }

  Future deleteOrder(String id, String idOrder) async {
    final docOrder = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Orders")
        .doc(idOrder);
    await docOrder.delete();
  }

  Future getData(String id) async {
    List items = [];
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .collection("Carts")
          .get()
          .then((querysnapshot) {
        querysnapshot.docs.forEach((element) {
          items.add(element.data());
        });
      });
      return items;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataSanPham() async {
    List items = [];
    try {
      await FirebaseFirestore.instance
          .collection("SanPham")
          .get()
          .then((querysnapshot) {
        querysnapshot.docs.forEach((element) {
          items.add(element.data());
        });
      });
      return items;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future addPhanHoi(PhanHoi phanHoi) async {
    final docPhanHoi = FirebaseFirestore.instance.collection('PhanHoi').doc();
    phanHoi.maPhanhoi = docPhanHoi.id;
    await docPhanHoi.set(phanHoi.toJson());
  }
}
