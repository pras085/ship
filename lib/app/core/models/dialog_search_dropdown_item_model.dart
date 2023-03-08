import 'package:flutter/material.dart';

class DialogSearchDropdownItemModel {
  String id;
  String value;

  DialogSearchDropdownItemModel({@required this.id, @required this.value});

  DialogSearchDropdownItemModel.copy(DialogSearchDropdownItemModel item) {
    id = item.id;
    value = item.value;
  }
}
