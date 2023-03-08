import 'package:get/get.dart';

class CarouselGalleryController extends GetxController {
  var listFlick = [].obs;
  var link = [
    "https://www.theuiaa.org/wp-content/uploads/2021/01/Dolomites-stock-UIAA.jpg",
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "https://www.theuiaa.org/wp-content/uploads/2021/01/Dolomites-stock-UIAA.jpg",
    "https://www.theuiaa.org/wp-content/uploads/2021/01/Dolomites-stock-UIAA.jpg",
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"
  ].obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {
    listFlick.forEach((element) {
      
    });
  }
}
