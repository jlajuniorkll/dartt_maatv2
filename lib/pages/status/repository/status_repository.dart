import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';

class StatusRepository {
  final fireRef = FirebaseFirestore.instance.collection('status');

// buscar todas os canais
  Future<GenericsResult<StatusModel>> getAllStatus() async {
    try {
      final QuerySnapshot snapStatus = await fireRef.orderBy('priority').get();

      if (snapStatus.docs.isNotEmpty) {
        List<StatusModel> data =
            snapStatus.docs.map((d) => StatusModel.fromDocument(d)).toList();
        return GenericsResult<StatusModel>.success(data);
      } else {
        return GenericsResult.error('Não existem canais cadastrados!');
      }
    } catch (e) {
      return GenericsResult.error(
          'Erro ao buscar dados no servidor --Status--');
    }
  }

    Future<GenericsResult<StatusModel>> getStatusActive() async {
    try {
      final QuerySnapshot snapStatus = await fireRef.orderBy('priority').where('isActive', isEqualTo: true).get();
      if (snapStatus.docs.isNotEmpty) {
        List<StatusModel> data =
            snapStatus.docs.map((d) => StatusModel.fromDocument(d)).toList();
        return GenericsResult<StatusModel>.success(data);
      } else {
        return GenericsResult.error('Não existem canais cadastrados!');
      }
    } catch (e) {
      return GenericsResult.error(
          'Erro ao buscar dados no servidor --Status--');
    }
  }

// salvar os canais
  Future<void> addStatus({required StatusModel status}) async {
    status.id = fireRef.doc().id;
    try {
      await fireRef.doc(status.id).set(status.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// deletar canais
  Future<void> deleteStatus({required String statusId}) async {
    try {
      await fireRef.doc(statusId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// editar canais
  Future<void> updateStatus({required StatusModel status}) async {
    try {
      await fireRef.doc(status.id).update(status.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> reorderUpdate(
      {required StatusModel status, required int newPriority}) async {
    try {
      await fireRef.doc(status.id).update({'priority': newPriority});
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
