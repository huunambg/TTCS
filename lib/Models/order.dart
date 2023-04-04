class Orders {
  String? maOrder;
  String? tenOrder;
  String? tenKhachHang;
  int? sdt;
  String? diaChiOrder;
  int? trangThaiOrder;
  int tongTien;
  String? image;
  String? chiTietOrder;
  int? soLuong;
  String? ngayDuKien;
  String? ngayOrder;
  int? gia;

  Orders(
      {this.maOrder,
      this.tenOrder,
      this.tenKhachHang,
      this.sdt,
      this.diaChiOrder,
      this.tongTien = 0,
      this.trangThaiOrder,
      this.image,
      this.soLuong,
      this.gia,
      this.ngayDuKien,
      this.ngayOrder,
      this.chiTietOrder});

  Map<String, dynamic> toJson() => {
        'maOrder': maOrder,
        'tenOrder': tenOrder,
        'tenKhachHang': tenKhachHang,
        'sdt': sdt,
        'gia':gia,
        'diaChiOrder': diaChiOrder,
        'trangThaiOrder': trangThaiOrder,
        'tongTien': tongTien,
        'chiTietOrder': chiTietOrder,
        'image': image,
        'soLuong': soLuong,
        'ngayDuKien': ngayDuKien,
        'ngayOrder': ngayOrder
      };
}
