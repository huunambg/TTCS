class Carts {
  String? maSP;
  String? tenSP;
  int? gia;
  String? loaiSP;
  String? img;
  String? chitietSP;
  int? sl;
  int? sum;
  Carts(
      {this.maSP,
      this.tenSP,
      this.gia,
      this.loaiSP,
      this.img,
      this.chitietSP,
      this.sl,
      this.sum});

  Map<String, dynamic> toJson() => {
        'maSP': maSP,
        'tenSP': tenSP,
        'gia': gia,
        'loaiSP': loaiSP,
        'img': img,
        'chitietSP': chitietSP,
        'sl': sl,
        'sum': sum
      };
}
