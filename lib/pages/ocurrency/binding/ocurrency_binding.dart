import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/pagecontroller.dart';
import 'package:get/get.dart';

class OcurrencyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PageManager());
    Get.put(OcurrencyController());
  }
}