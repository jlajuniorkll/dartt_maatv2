
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

@override
  void initState() {
    super.initState();
      Future.delayed(const Duration(seconds: 4)).then((_){
      Get.toNamed(PageRoutes.signin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}