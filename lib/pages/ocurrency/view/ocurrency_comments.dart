import 'package:dartt_maat_v2/common/ballon_card.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/pages/comments/controller/comments_controller.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  final OcurrencyModel ocurrency = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Chat protocolo: ${ocurrency.protocolo}'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: GetBuilder<CommentsController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: controller.allComents.length,
                  itemBuilder: (_, index) {
                    final usuarioLogado =
                        Get.find<UserController>().usuarioLogado;
                    bool isMe = false;
                    if (controller.allComents[index].usuario!.id ==
                        usuarioLogado!.id) {
                      isMe = true;
                    }
                    final title = controller.allComents[index].usuario!.name;
                    final message = controller.allComents[index].description!;
                    final dataComentario =
                        controller.allComents[index].dataComentario!;
                    return BalloonCard(
                        title: title!,
                        message: message,
                        isMe: isMe,
                        dataComentario: dataComentario);
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.comentarioController,
                        decoration: const InputDecoration(
                          hintText: 'Digite uma mensagem...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        final saveOK = await controller.addComment(
                            controller.comentarioController.text, ocurrency);
                        if (saveOK) {
                          controller.cleanScreenComment();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
