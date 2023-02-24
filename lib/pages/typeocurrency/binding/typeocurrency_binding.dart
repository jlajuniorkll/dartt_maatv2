import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:get/instance_manager.dart';

class TypeOcurrencyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(TypeOcurrencyController());
  }
}