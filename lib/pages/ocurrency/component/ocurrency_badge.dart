import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:flutter/material.dart';

class BadgeCustom extends StatelessWidget {
  const BadgeCustom({super.key, required this.previsao});

  final Previsao previsao;

  @override
  Widget build(BuildContext context) {
    LinearGradient colorGradient = linearGreenStatus;
    Color colorText = Colors.black;
    switch (previsao.id) {
      case "0":
        colorGradient = linearGreenStatus;
        colorText = Colors.white;
        break;
      case "1":
        colorGradient = linearYellowStatus;
        colorText = Colors.black;
        break;
      case "2":
        colorGradient = linearRedStatus;
        colorText = Colors.white;
        break;
      case "3":
        colorGradient = linearGreyStatus;
        colorText = Colors.black;
        break;
    }
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            gradient: colorGradient,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.elliptical(100, 50))),
        child: Center(
            child: Text(
          previsao.name,
          style: TextStyle(color: colorText, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
