import 'package:flutter/material.dart';

Widget spacer(double height, double width) {
  return SizedBox(
    height: height,
    width: width,
  );
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

String orientation(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait)
    return 'portrait';
  return 'landscape';
}
