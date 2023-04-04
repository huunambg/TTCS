import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

class CustomBanner extends StatefulWidget {
  const CustomBanner({super.key});

  @override
  State<CustomBanner> createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: AssetImage("assets/images/banner1.jpg"),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Color.fromARGB(255, 156, 189, 247).withOpacity(1),
            Color.fromARGB(44, 0, 0, 0).withOpacity(.3),
          ],
        ),
      ),
      title: 'Sale of 5% toàn bộ nhẫn tại cửa hàng khi mua hàng online!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2.500.000₫/1c',
      rightSubtitle: 'set nhẫn cưới chỉ còn 5.000.000₫',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: AssetImage("assets/images/banner3.jpg"),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Color.fromARGB(255, 139, 173, 233).withOpacity(1),
            Color.fromARGB(46, 0, 0, 0).withOpacity(.3),
          ],
        ),
      ),
      title: 'Nhận ngay voncher giảm ngay 5% dành cho người mới!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2.500.000₫/1c',
      rightSubtitle: 'Khuyên tai vàng chỉ còn 5.xxx.xxx₫',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Color.fromARGB(255, 143, 180, 245).withOpacity(1),
            Color.fromARGB(43, 0, 0, 0).withOpacity(.3),
          ],
        ),
      ),
      image: AssetImage("assets/images/banner2.jpg"),
      title: 'Khuyên tai vàng chỉ còn 2xx',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2.xxx.xxx₫/1cặp',
      rightSubtitle: 'set khuyên tai 5.xxx.xxx₫',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ClipRRect(
        child: CustomCarouselSlider(
          items: itemList,
          height: 140,
          width: MediaQuery.of(context).size.width * 1,
          autoplay: true,
        ),
      ),
    );
  }
}
