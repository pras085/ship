import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';

class ZoPromoTransporterVerticalDash extends StatelessWidget {
  final double height;
  final double width;

  const ZoPromoTransporterVerticalDash({
    Key key,
    this.width = 1,
    @required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: const _DashedLineVerticalPainter(),
    );
  }
}

class _DashedLineVerticalPainter extends CustomPainter {
  const _DashedLineVerticalPainter();
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Color(ListColor.colorDash)
      ..strokeWidth = size.width;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
