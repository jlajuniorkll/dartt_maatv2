
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:get/instance_manager.dart';

class StatusBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StatusController());
  }
}