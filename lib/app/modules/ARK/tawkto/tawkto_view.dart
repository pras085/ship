import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:get/get.dart';

class TawktoView extends GetView{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Tawk(
            directChatLink: 'https://tawk.to/chat/60585510f7ce18270932864b/1f1cgoiiq',
            visitor: TawkVisitor(
                name: 'Ayoub AMINE',
                email: 'ayoubamine2a@gmail.com',
            ),
        ),
      ),
    );
  }

}