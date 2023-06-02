import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoadingServices {

  static void showLoading() {
    Get.dialog(const Dialog(
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
