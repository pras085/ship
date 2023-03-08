import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransportMarketController extends GetxController {
  //TODO: Implement BigfleetsController

  final List<String> imgList = [
    'gambar_example.jpeg',
    'gambar_example.jpeg',
    'gambar_example.jpeg',
    'gambar_example.jpeg',
    'gambar_example.jpeg',
    'gambar_example.jpeg'
  ];

  var imageSliders = [].obs;

  final indexImageSlider = 0.obs;

  @override
  void onInit() {
    imageSliders.value = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Image(
                          image: AssetImage("assets/" + item),
                          width: 1000,
                          fit: BoxFit.cover,
                        ),
                        // Positioned(
                        //   bottom: 0.0,
                        //   left: 0.0,
                        //   right: 0.0,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Color.fromARGB(200, 0, 0, 0),
                        //           Color.fromARGB(0, 0, 0, 0)
                        //         ],
                        //         begin: Alignment.bottomCenter,
                        //         end: Alignment.topCenter,
                        //       ),
                        //     ),
                        //     padding: EdgeInsets.symmetric(
                        //         vertical: 10.0, horizontal: 20.0),
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
