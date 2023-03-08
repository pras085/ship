import 'package:get/get.dart';
import 'package:muatmuat/app/modules/carousel_gallery/carousel_gallery_controller.dart';

class CarouselGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarouselGalleryController>(
      () => CarouselGalleryController(),
    );
  }
}
