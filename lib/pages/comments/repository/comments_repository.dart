import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/comentario_model.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';

class CommentsRepository {
  final fireRef = FirebaseFirestore.instance.collection('ocurrency');

  Future<bool> addComment(
      {required ComentarioModel comentario,
      required OcurrencyModel ocurrency}) async {
    try {
      await fireRef
          .doc(ocurrency.id)
          .collection('comentarios')
          .doc()
          .set(comentario.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<GenericsResult<ComentarioModel>> getAllComentarios(
      {required OcurrencyModel ocurrency}) async {
    try {
      final QuerySnapshot snapComentario = await fireRef
          .doc(ocurrency.id)
          .collection('comentarios')
          .orderBy('dataComentario', descending: true)
          .get();
      if (snapComentario.docs.isNotEmpty) {
        List<ComentarioModel> data = snapComentario.docs
            .map((d) => ComentarioModel.fromDocument(d))
            .toList();
        return GenericsResult<ComentarioModel>.success(data);
      } else {
        return GenericsResult.error('Não existem comentarios!');
      }
    } catch (e) {
      return GenericsResult.error(
          'Erro ao consultar base de dados. -COMENTARIOS-');
    }
  }
}
