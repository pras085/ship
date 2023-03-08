import 'package:get/get.dart';
import 'package:muatmuat/app/modules/article/article_model.dart';

class ArticleController extends GetxController {
  var listArticle = List<ArticleModel>().obs;

  @override
  void onInit() {
    listArticle.clear();
    listArticle.value.add(ArticleModel(
        title: "Title 1",
        description: "This is an example.",
        date: DateTime.now(),
        image:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        url: ""));
    listArticle.value.add(ArticleModel(
        title: "Title 2",
        description: "This is an example.",
        date: DateTime.now(),
        image:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        url: ""));
    listArticle.value.add(ArticleModel(
        title: "Title 3",
        description: "This is an example.",
        date: DateTime.now(),
        image:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        url: ""));
    listArticle.value.add(ArticleModel(
        title: "Title 4",
        description: "This is an example.",
        date: DateTime.now(),
        image:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        url: ""));
    listArticle.value.add(ArticleModel(
        title: "Title 5",
        description: "This is an example.",
        date: DateTime.now(),
        image:
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
        url: ""));
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
