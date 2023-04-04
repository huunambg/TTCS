import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HuongDan extends StatelessWidget {
  const HuongDan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hướng dẫn"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(95, 128, 115, 115))),
        backgroundColor: Colors.red,
      ),
      body: ListView(padding: EdgeInsets.all(5), children: [
        Text("""Hướng dẫn cách mua hàng trên Shopee
Đăng ký tài khoản mua hàng Shopee
Truy cập trực tiếp vào trang shopee.vn đăng ký tài khoản mua hàng.
Hướng dẫn mua hàng trên Shopee bước đăng ký tài khoản
Tại trang chủ bạn click vào ô “Đăng ký” phía trên góc bên phải màn hình rồi điền đầy đủ thông tin hệ thống yêu cầu bao gồm số điện thoại, mã xác minh (mã được shopee gửi về số điện thoại bạn đăng ký), tên đăng nhập, mật khẩu, xác nhận mật khẩu và mã captra. Sau khi hoàn tất bạn click vào ô “ĐĂNG KÝ” là xong.
Hoặc bạn có thể đăng ký trực tiếp bằng email hoặc facebook bằng các ấn vào ô đăng nhập bằng facebook, email sau đó nhập mã xác nhận nhé!
Điền đầy đủ thông tin đăng ký Shopee
Nếu bạn đã có tài khoản thì có thể tiến hành đăng nhập và bỏ qua bước này.
Tìm sản phẩm muốn mua trên Shopee
Sau khi đăng nhập tài khoản xong, bạn có thể tìm kiếm sản phẩm mình muốn mua bằng cách dùng công cụ search trên trang chủ hoặc chọn theo danh mục sản phẩm. Mình thường tìm kiếm sản phẩm dựa theo tin khuyến mãi, vì giá thường rẻ hơn. Ngoài ra mình còn tìm mã giảm giá trên http://mgg.vn trước khi mua hàng, vì đi kèm mã giảm giá là link dẫn đến chương trình khuyến mãi áp dụng cho mã giảm giá đó.
Hướng dẫn mua hàng trên Shopee, hướng dẫn tìm kiếm sản phẩmHướng dẫn mua hàng trên Shopee, hướng dẫn tìm kiếm mã giảm giá trên http://mgg.vnHướng dẫn mua hàng trên Shopee tìm kiếm sản phẩm theo flash sale hoặc theo thương hiện
Chọn sản phẩm muốn mua trên Shopee
Click vào sản phẩm bạn muốn mua và kiểm tra thông tin bạn nhấn vào sản phẩm bạn muốn mua, ấn chọn ngay và điền số lượng yêu cầu rồi chọn “Thêm vào giỏ hàng”
Hướng dẫn mua hàng trên Shopee bước mua sản phẩm
Kiểm tra lại sản phẩm trong giỏ hàng Shopee và Nhập mã giảm giá Shopee
Vào phần “Giỏ hàng” check lại một lần nữa sản phẩm của bạn. Ở bước này bạn có thể hủy chọn, hoặc xóa sản phẩm khỏi giỏ hàng thậm chí là tăng giảm số lượng sản phẩm cần mua.
Và nhập mã giảm giá mà bạn tìm được tại https://mgg.vn/ma-giam-gia/shopee/.
Nếu mọi thứ OK hết thì bấm vào Mua Hàng.
Hướng dẫn mua hàng trên Shopee, bước xem giỏ hàng
Kiểm tra lại địa chỉ giao hàng trên Shopee, đơn vị vận chuyển
Trang này bạn sẽ kiểm tra địa chỉ nhận hàng. Kiểm tra kĩ thông tin nhận hàng gồm họ tên, số điện thoại và địa chỉ. Kiểm tra lại đơn vị vận chuyển, mỗi đơn vị vận chuyển có mức phí riêng cho từng địa điểm và thời gian giao hàng khác nhau. Bạn hãy chọn cho mình đơn vị vận chuyển phù hợp nhất. Cuối cùng là thay đổi bước thanh toán.
Hướng dẫn mua hàng trên Shopee kiểm tra địa chỉ giao hàng, nhập mã giảm giá
Thanh toán
Cuối cùng là bước thanh toán. Bạn chọn hình thức thanh toán bằng thẻ tín dụng/ ghi nợ hoặc thanh toán tại nhà. Hiện tại có rất nhiều ưu đãi từ Shopee dành cho chủ thẻ tín dụng, ghi nợ. Tham khảo bài viết https://mgg.vn/huong-dan-cach-su-dung-deal-uu-dai-tu-ngan-hang-tren-shopee để hiểu rõ hơn.
Hướng dẫn mua hàng trên Shopee chọn phương thức thanh toán
Nếu là lần đầu mua hàng trên Shopee bạn nên chọn hình thức thanh toán tại nhà. Còn nếu đã mua nhiều lần hoặc có thẻ visa bạn có thể thanh toán trực tiếp luôn. Thông thường hình thức này bạn sẽ nhận được ưu đãi thêm từ 7-20% nữa đấy. Bấm vào Thẻ Tín Dụng/ Ghi nợ để thanh toán bằng thẻ.
Bạn có thể search google: “TPBank giảm giá Shopee mgg.vn” với TPBank là ngân hàng của mình. Để tìm khuyến mãi cho ngân hàng.
Chú ý nhớ nhập mã giảm giá nếu có nhé! Chúng sẽ giúp bạn tiết kiệm được thêm 1 khoản chi phí đấy.
Sau khi hoàn tất những bước trên bạn click vào ô ĐẶT HÀNG ở phía cuối là xong nhé!
Trên đây là những bước cơ bản nhất để đặt thành công đơn hàng trên Shopee. Chỉ cần một vài thao tác là bạn có thể yên tâm ngồi chờ nhận hàng rồi. Bạn cũng có thể theo dõi đơn hàng bằng cách nhớ mã đơn hàng và gọi lên tổng đài để xác nhận là được nhé. Chúc các bạn được những sản phẩm chất lượng với giá cực rẻ nhé!
""")
      ]),
    );
  }
}
