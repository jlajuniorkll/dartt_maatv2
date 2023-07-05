import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/comentario_model.dart';
import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/results/uploadfiles_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OcurrencyRepository {
  final storageRef = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;
  final fireRef = FirebaseFirestore.instance.collection('ocurrency');

  Future<UploadFilesResult<UploadTask>> setFileFirebase(
      {required Uint8List fileBytes, required String fileName}) async {
    try {
      UploadTask uploadTask =
          storageRef.ref().child("files/$fileName").putData(fileBytes);
      return UploadFilesResult.success(uploadTask);
    } catch (e) {
      return UploadFilesResult.error(
          'Erro ao fazer o upload do arquivo no servidor!');
    }
  }

  Future<bool> removeFileFirebase(String fileName) async {
    try {
      final res = storageRef.ref().child("files/$fileName");
      await res.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> get getProtocolo async {
    try {
      var ano = DateTime.now().year.toString();
      final ref = firestore.doc('aux/counter');
      final resultMap = await firestore.runTransaction(
        (tx) async {
          final doc = await tx.get(ref);
          final orderId = doc.data()!['current'] as int;
          tx.update(ref, {'current': orderId + 1});
          return {'orderId': orderId};
        },
      );
      var resultId = resultMap['orderId'] as int;
      var resultfinal = '$ano/$resultId';
      return resultfinal;
    } catch (e) {
      return Future.error('Falha ao gerar o número do pedido');
    }
  }

  // salvar os canais
  Future<void> addOcurrency({required OcurrencyModel ocurrency}) async {
    try {
      ocurrency.id = fireRef.doc().id;
      await fireRef.doc(ocurrency.id).set(ocurrency.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

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

  Future<void> updateOcurrency({required OcurrencyModel ocurrency}) async {
    try {
      await fireRef.doc(ocurrency.id).update(ocurrency.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  // buscar todas os canais
  Future<GenericsResult<OcurrencyModel>> getAllOcurrency() async {
    try {
      final QuerySnapshot snapOcurrency =
          await fireRef.orderBy('protocolo').get();

      if (snapOcurrency.docs.isNotEmpty) {
        List<OcurrencyModel> data = snapOcurrency.docs
            .map((d) => OcurrencyModel.fromDocument(d))
            .toList();
        return GenericsResult<OcurrencyModel>.success(data);
      } else {
        return GenericsResult.error('Não existem ocorrências cadastradas!');
      }
    } catch (e) {
      return GenericsResult.error(
          'Erro ao consultar base de dados. -OCORRENCIA-');
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
