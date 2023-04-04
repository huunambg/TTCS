class Users {
  String? id;
  String? email;
  String? matkhau;
  String? vaitro;
  String? tenNguoiDung;
  Users({this.id, this.email, this.matkhau, this.vaitro,this.tenNguoiDung="User"});

  Map<String, dynamic> toJson() =>
      {'id': id, 'email': email, 'matkhau': matkhau, 'vaitro': vaitro};
}
