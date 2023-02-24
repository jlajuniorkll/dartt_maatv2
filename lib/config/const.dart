import 'package:flutter/material.dart';

const version = "V2.0 - ncloud";
const linearBlue = LinearGradient(
    colors: [
      Color(0xFF3366FF),
      Color(0xFF00CCFF),
    ],
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 0.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp);

const linearGreen = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 149, 20),
      Color.fromARGB(255, 190, 255, 117),
    ],
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 0.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp);
