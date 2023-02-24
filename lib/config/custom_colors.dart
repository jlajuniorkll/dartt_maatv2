import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(0, 0, 205, .1),
  100: const Color.fromRGBO(0, 0, 205, .2),
  200: const Color.fromRGBO(0, 0, 205, .3),
  300: const Color.fromRGBO(0, 0, 205, .4),
  400: const Color.fromRGBO(0, 0, 205, .5),
  500: const Color.fromRGBO(0, 0, 205, .6),
  600: const Color.fromRGBO(0, 0, 205, .7),
  700: const Color.fromRGBO(0, 0, 205, .8),
  800: const Color.fromRGBO(0, 0, 205, .9),
  900: const Color.fromRGBO(0, 0, 205, 1),
};

abstract class CustomColors {
  static Color customContrastColor = const Color.fromARGB(255, 255, 98, 0);
  static MaterialColor customSwatchColor =
      MaterialColor(0xFF1E90FF, _swatchOpacity);
}

const colorPrimaryClient = Colors.blue;
const colorSelectedClient = Colors.white;
final colorUnSelectedClient = Colors.white.withAlpha(100);
