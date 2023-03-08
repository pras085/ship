import 'package:get/get.dart';
import 'package:muatmuat/app/modules/article/article_controller.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ArticleController());
  }
}
