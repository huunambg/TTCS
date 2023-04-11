class Danhgia {
  String? maDanhgia;
  String? maSP;
  String? tenNguoiDung;
  String? noiDung;
  String? thoiGian;
  String? img;
  Danhgia(
      {this.maDanhgia,
      this.noiDung,
      this.maSP,
      this.tenNguoiDung,
      this.thoiGian,
      this.img});
  Map<String, dynamic> toJson() => {
        'maDanhgia': maDanhgia,
        'maSP': maSP,
        'tenNguoiDung': tenNguoiDung,
        'noiDung': noiDung,
        'thoiGian': thoiGian,
        'img': img
      };
}
