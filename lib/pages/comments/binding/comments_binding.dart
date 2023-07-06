import 'package:dartt_maat_v2/pages/comments/controller/comments_controller.dart';
import 'package:get/instance_manager.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommentsController());
  }
}
