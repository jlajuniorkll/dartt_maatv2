
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [
                     Color(0xFF3366FF),
                     Color(0xFF00CCFF),
                  ],
                  begin:  FractionalOffset(0.0, 0.0),
                  end:  FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 200,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'images/procon.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
               Text(
                'Olá, ${controller.usuarioLogado?.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Versão: $version', style: TextStyle(fontSize: 10),)
            ]));
  }
}
