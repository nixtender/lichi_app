import 'package:flutter/material.dart';

class PictureIndicatorClip extends CustomClipper<Path> {
  double k = 1;
  PictureIndicatorClip(this.k);

  @override
  Path getClip(Size size) {
    double radius = 2;

    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(10 * k, 0)
      ..arcToPoint(Offset(10 * k, 2 * radius), radius: Radius.circular(radius))
      ..lineTo(radius, 2 * radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
