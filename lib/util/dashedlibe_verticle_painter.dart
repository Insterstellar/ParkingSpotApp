import 'package:flutter/cupertino.dart';
import 'package:parking/misc/mycolors/mycolors.dart';


class DashedLineHorizontalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5,
        dashSpace = 3,
        startX = 0;
    final paint = Paint()
      ..color = MyColors.primary6_light1
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}