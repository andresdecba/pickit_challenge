import 'package:flutter/material.dart';

const kOrange = Color(0xFFFF8A00);

const kGrey = Color(0xFFd2d2d2);

const kPadding = 15.0;

const kBorderRdius = 10.0;

BoxDecoration containerDecoration() {
  return const BoxDecoration(
    color: Colors.amber,
  );
}

RoundedRectangleBorder roundedBorders() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kBorderRdius),
  );
}
