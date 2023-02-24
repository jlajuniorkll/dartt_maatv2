import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:get/instance_manager.dart';

class UserBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}