import 'package:flutter/material.dart';

class ArrayPainter extends CustomPainter {
  final List<int> arrayToSort;

  ArrayPainter(this.arrayToSort);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = size.width / arrayToSort.length
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < arrayToSort.length; i++) {
      paint.color =
          HSVColor.fromAHSV(1, arrayToSort[i].toDouble(), 1.0, 1.0).toColor();

      canvas.drawLine(
          Offset(i.toDouble(), size.height),
          Offset(i.toDouble(), size.height - arrayToSort[i].toDouble() * 1.7),
          paint);
    }
  }

  @override
  bool shouldRepaint(ArrayPainter oldDelegate) {
    return true;
  }
}
