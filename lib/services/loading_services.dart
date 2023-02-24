import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoadingServices {

  static void showLoading() {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const[
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('Carregando...')
          ],
        ),
      ),
    ), name: 'Loading');
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }
}
