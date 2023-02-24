
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:get/instance_manager.dart';

class ChannelBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ChannelController());
  }
}