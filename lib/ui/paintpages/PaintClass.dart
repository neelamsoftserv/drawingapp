import 'package:flutter/material.dart';

class PaintClass extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint();
    canvas.drawLine(
      Offset(size.width *1/6, size.height *1/2),
      Offset(size.width *5/6, size.height *1/2),
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    throw UnimplementedError();
  }


}
