import 'package:flutter/material.dart';

class MessageBubblePainter extends CustomPainter {
  final Color color;
  final Alignment alignment;

  MessageBubblePainter({
    required this.color,
    required this.alignment,
  });

  final radius = 8.0;
  final x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            size.width - 8,
            size.height,
            bottomLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
            topLeft: Radius.circular(radius),
          ),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
      var path = Path();
      path.moveTo(size.width - x, size.height - 10);
      path.lineTo(size.width - x, size.height);
      path.lineTo(size.width, size.height);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            size.width - x,
            0.0,
            size.width,
            size.height,
            topRight: Radius.circular(radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
    } else {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            x,
            0,
            size.width,
            size.height,
            bottomRight: Radius.circular(radius),
            topRight: Radius.circular(radius),
            topLeft: Radius.circular(radius),
          ),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
      var path = Path();
      path.moveTo(0, size.height);
      path.lineTo(x, size.height);
      path.lineTo(x, size.height - 10);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0.0,
            x,
            size.height,
            topRight: Radius.circular(radius),
          ),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}