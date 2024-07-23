import 'package:flutter/material.dart';

class AppCustomClipPathWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, 0); // 1. point
    path.quadraticBezierTo(
      w - 28, // 2. point
      h * 0.5, // 2. point
      0, // 3. point
      h, // 3. point
    );
    path.quadraticBezierTo(
      w * 0.5, // 4. Point
      h - 15, // 4. Point
      w, // 5. Point
      h, // 5. Point
    );
    path.lineTo(w, 0); // 6. point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
