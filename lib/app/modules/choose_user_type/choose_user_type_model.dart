import 'package:flutter/material.dart';

class ChooseUserTypeModel {
  @required
  final String title;
  @required
  final Function onTap;
  @required
  final String urlIcon;

  ChooseUserTypeModel({this.title, this.onTap, this.urlIcon});
}
