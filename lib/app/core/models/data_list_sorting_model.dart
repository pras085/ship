import 'package:get/get.dart';

class DataListSortingModel {
  final String title;
  final String keyParam;
  final String titleASC;
  final String titleDESC;
  final RxString groupValue;
  bool isExpand = false;
  final bool isTitleASCFirst;

  DataListSortingModel(
      this.title, this.keyParam, this.titleASC, this.titleDESC, this.groupValue,
      {this.isTitleASCFirst = true});
}
