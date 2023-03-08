import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/article/article_controller.dart';
import 'package:muatmuat/app/modules/article/article_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class ArticleView extends GetView<ArticleController> {
  double widthArticle(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Article"),
      ),
      body: SafeArea(
        child: Obx(() => ListView.builder(
              itemCount: controller.listArticle.length,
              itemBuilder: ((content, index) {
                var article = controller.listArticle.value[index];
                return articleView(context, article);
              }),
            )),
      ),
    );
  }

  Widget articleView(BuildContext context, ArticleModel article) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(0),
            minWidth: 0,
            onPressed: () {
              Get.toNamed(Routes.WEBVIEW);
            },
            child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 130,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: widthArticle(context) * 1 / 3,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(article.image,
                                height: 130, fit: BoxFit.cover),
                            //     Image(
                            //   image: AssetImage("assets/gambar_example.jpeg"),
                            //   height: 130,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        Container(
                          width: (widthArticle(context) * 2 / 3) - 20,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CustomText(article.description,
                                      color: Color(
                                          ListColor.colorTextTitleArticle),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                  SizedBox(height: 3),
                                  CustomText(article.description,
                                      color:
                                          Color(ListColor.colorTextDescArticle),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ],
                              ),
                              CustomText("HomeLabelMenuArticlesReadMore".tr,
                                  color:
                                      Color(ListColor.colorTextReadMoreArticle),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ],
                          ),
                        )
                      ]),
                ))),
      ),
    );
  }
}
