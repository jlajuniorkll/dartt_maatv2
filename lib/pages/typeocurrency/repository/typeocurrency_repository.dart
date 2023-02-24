import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';

class TypeOcurrencyRepository {
  final fireRef = FirebaseFirestore.instance.collection('typeocurrency');

// buscar todas os canais
  Future<GenericsResult<TypeOcurrencyModel>> getAllTypeOcurrency() async {
    try {
      final QuerySnapshot snapTypeOcurrency =
          await fireRef.orderBy('name').get();

      if (snapTypeOcurrency.docs.isNotEmpty) {
        List<TypeOcurrencyModel> data = snapTypeOcurrency.docs
            .map((d) => TypeOcurrencyModel.fromDocument(d))
            .toList();
        return GenericsResult<TypeOcurrencyModel>.success(data);
      } else {
        return GenericsResult.error('Não existem tipos cadastrados!');
      }
    } catch (e) {
      return GenericsResult.error('Erro ao recuperar dados do servidor -TIPO-');
    }
  }

// salvar os canais
  Future<void> addTypeOcurrency(
      {required TypeOcurrencyModel typeOcurrency}) async {
    typeOcurrency.id = fireRef.doc().id;
    try {
      await fireRef.doc(typeOcurrency.id).set(typeOcurrency.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// deletar canais
  Future<void> deleteTypeOcurrency({required String typeOcurrencyId}) async {
    try {
      await fireRef.doc(typeOcurrencyId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// editar canais
  Future<void> updateTypeOcurrency(
      {required TypeOcurrencyModel typeOcurrency}) async {
    try {
      await fireRef.doc(typeOcurrency.id).update(typeOcurrency.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
