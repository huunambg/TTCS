class Orders {
  String? maOrder;
  String? maNguoiDung;
  String? tenOrder;
  String? tenKhachHang;
  int? sdt;
  String? diaChiOrder;
  int? trangThaiOrder;
  int tongTien;
  String? size;
  String? image;
  String? chiTietOrder;
  int? soLuong;
  String? ngayDuKien;
  String? ngayOrder;
  String? ngayNhan;
  int? gia;

  Orders(
      {this.maOrder,
      this.tenOrder,
      this.tenKhachHang,
      this.sdt,
      this.size,
      this.diaChiOrder,
      this.tongTien = 0,
      this.maNguoiDung,
      this.trangThaiOrder,
      this.image,
      this.soLuong,
      this.gia,
      this.ngayDuKien,
      this.ngayOrder,
      this.ngayNhan = "chưa nhận",
      this.chiTietOrder});

  Map<String, dynamic> toJson() => {
        'maOrder': maOrder,
        'tenOrder': tenOrder,
        'maNguoiDung': maNguoiDung,
        'tenKhachHang': tenKhachHang,
        'sdt': sdt,
        'size': size,
        'gia': gia,
        'diaChiOrder': diaChiOrder,
        'trangThaiOrder': trangThaiOrder,
        'tongTien': tongTien,
        'chiTietOrder': chiTietOrder,
        'image': image,
        'soLuong': soLuong,
        'ngayNhan': ngayNhan,
        'ngayDuKien': ngayDuKien,
        'ngayOrder': ngayOrder
      };
}
