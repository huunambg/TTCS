class PhanHoi {
  String? maPhanhoi;
  String? tenNguoiDung;
  String? noiDung;
  String? thoiGian;
  PhanHoi({this.maPhanhoi, this.noiDung, this.tenNguoiDung, this.thoiGian});
  Map<String, dynamic> toJson() => {
        'maPhanHoi': maPhanhoi,
        'tenNguoiDung': tenNguoiDung,
        'noiDung': noiDung,
        'thoiGian': thoiGian,
      };
}
