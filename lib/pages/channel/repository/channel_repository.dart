import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';

class ChannelRepository {
  final fireRef = FirebaseFirestore.instance.collection('channel');

// buscar todas os canais
  Future<GenericsResult<ChannelModel>> getAllChannels() async {
    try {
      final QuerySnapshot snapChannel = await fireRef.orderBy('name').get();

      if (snapChannel.docs.isNotEmpty) {
        List<ChannelModel> data =
            snapChannel.docs.map((d) => ChannelModel.fromDocument(d)).toList();
        return GenericsResult<ChannelModel>.success(data);
      } else {
        return GenericsResult.error('Não existem canais cadastrados!');
      }
    } catch (e) {
      return GenericsResult.error('Erro ao consultar base de dados. -CANAIS-');
    }
  }

// salvar os canais
  Future<void> addChannel({required ChannelModel channel}) async {
    try {
      channel.id = fireRef.doc().id;
      await fireRef.doc(channel.id).set(channel.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// deletar canais
  Future<void> deleteChannel({required String channelId}) async {
    try {
      await fireRef.doc(channelId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// editar canais
  Future<void> updateChannel({required ChannelModel channel}) async {
    try {
      await fireRef.doc(channel.id).update(channel.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
