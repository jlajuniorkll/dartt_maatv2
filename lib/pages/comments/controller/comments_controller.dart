import 'package:dartt_maat_v2/models/comentario_model.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/pages/comments/repository/comments_repository.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/loading_services.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final commentsRepository = CommentsRepository();
  final utilServices = UtilsServices();

  final usuarioLogado = Get.find<UserController>().usuarioLogado;
  List<ComentarioModel> allComents = [];
  TextEditingController comentarioController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    cleanScreenComment();
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    if (isLoading) {
      LoadingServices.showLoading();
    } else {
      LoadingServices.hideLoading();
    }
    update();
  }

  Future<void> getAllComentarios({required OcurrencyModel ocurrency}) async {
    setLoading(true);
    cleanScreenComment();
    GenericsResult<ComentarioModel> commentsResult =
        await commentsRepository.getAllComentarios(ocurrency: ocurrency);
    setLoading(false);

    commentsResult.when(success: (data) {
      allComents.assignAll(data);
      update();
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar comentarios ou não existe nenhuma ocorrência registrada!",
        backgroundColor: Colors.yellow,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.yellow,
        colorText: Colors.black,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<bool> addComment(String comment, OcurrencyModel ocurrency) async {
    ComentarioModel comentario = ComentarioModel(
        usuario: usuarioLogado,
        description: comment,
        dataComentario: utilServices.getDataHoraAtual());
    await commentsRepository.addComment(
        comentario: comentario, ocurrency: ocurrency);
    getAllComentarios(ocurrency: ocurrency);
    return true;
  }

  void cleanScreenComment() {
    comentarioController.clear();
    allComents.clear();
    setLoading(false);
    update();
  }
}
