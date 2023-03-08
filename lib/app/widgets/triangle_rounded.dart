import 'package:flutter/material.dart';

class TriangleRounded extends CustomPainter {

  final bool useShadow;

  const TriangleRounded({this.useShadow = true});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF001537)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5764714, size.height * 0.9224400);
    path_0.cubicTo(
        size.width * 0.5383952,
        size.height * 0.9942533,
        size.width * 0.4616057,
        size.height * 0.9942533,
        size.width * 0.4235281,
        size.height * 0.9224400);
    path_0.lineTo(size.width * 0.05610286, size.height * 0.2294720);
    path_0.cubicTo(
        size.width * 0.009454619,
        size.height * 0.1414927,
        size.width * 0.05431095,
        size.height * 0.01666667,
        size.width * 0.1325748,
        size.height * 0.01666667);
    path_0.lineTo(size.width * 0.8674238, size.height * 0.01666653);
    path_0.cubicTo(
        size.width * 0.9456905,
        size.height * 0.01666653,
        size.width * 0.9905476,
        size.height * 0.1414927,
        size.width * 0.9438952,
        size.height * 0.2294720);
    path_0.lineTo(size.width * 0.5764714, size.height * 0.9224400);
    path_0.close();

    if (useShadow) canvas.drawShadow(path_0, Colors.black87, 8.0, false);
    canvas.drawPath(path_0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}