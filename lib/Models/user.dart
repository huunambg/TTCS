class Users {
  String? id;
  String? email;
  String? matkhau;
  int? sdt;
  String? diaChi;
  String? vaitro;
  String? tenNguoiDung;
  String? img;
  int? tuoi;
  Users(
      {this.id,
      this.email,
      this.matkhau,
      this.vaitro,
      this.img = "chưa cập nhật",
      this.tenNguoiDung = "User",
      this.diaChi = "chưa cập nhật",
      this.sdt = 0,
      this.tuoi});

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'matkhau': matkhau,
        'vaitro': vaitro,
        'diaChi': diaChi,
        'tuoi': tuoi,
        'sdt': sdt,
        'img': img,
        'tenNguoiDung': tenNguoiDung
      };
}
