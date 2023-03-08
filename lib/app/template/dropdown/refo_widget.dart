import 'package:flutter/material.dart';
import 'package:muatmuat/app/template/dropdown/drop_filter.dart';

class RefoWidget extends StatelessWidget {
  // final List truck;
  // final List carrier;

  // const RefoWidget({
  //   @required this.truck,
  //   @required this.carrier
  // });

  @override
  Widget build(BuildContext context) {
    // timeago.setLocaleMessages('id', LocaleMessagesId());
    // timeago.setLocaleMessages('en', LocaleMessagesEn());

    // int maxLength = 0;
    // for (var i = 0; i < description.keys.toList().length; i++) {
    //   if (description.keys.toList()[i].length >= maxLength) {
    //     maxLength = description.keys.toList()[i].length;
    //   }
    // }

    // if (maxLength > 10) maxLength = 10;
    return Scaffold(
      body: ListView(
        children: [
          DropdownFilter(),
        ],
      ),
    );
  }
}