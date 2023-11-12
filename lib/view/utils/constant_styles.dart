import 'package:flutter/cupertino.dart';

double screenPadding = 22;

sizedBox20() {
  return const SizedBox(
    height: 20,
  );
}

sizedBoxCustom(double size) {
  return SizedBox(
    height: size,
  );
}

var physicsCommon = const BouncingScrollPhysics();
