import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/anexo_model.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/models/cliente_model.dart';
import 'package:dartt_maat_v2/models/comentario_model.dart';
import 'package:dartt_maat_v2/models/fornecedor_model.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ocurrency_model.g.dart';

@JsonSerializable()
class OcurrencyModel {
  String? id;
  String? dataRegistro;
  String? dataAt;
  String? protocolo;
  String? dataOcorrencia;
  String? ocorrencia;
  Previsao? previsao;
  UserModel? responsavel; // somente para operador
  ChannelModel? channel; // somente para operador
  UserModel? user; // somente para operador
  StatusModel? status;
  ClienteModel? cliente;
  List<FornecedorModel>? fornecedores = [];
  List<AnexoModel>? anexos = [];
  List<ComentarioModel>? comentarios;
  TypeOcurrencyModel? typeOcurrencyId;

  OcurrencyModel({
    this.id,
    this.dataRegistro,
    this.dataAt,
    this.protocolo,
    this.dataOcorrencia,
    this.ocorrencia,
    this.previsao,
    this.responsavel,
    this.channel,
    this.user,
    this.status,
    this.cliente,
    this.fornecedores,
    this.anexos,
    this.comentarios,
    this.typeOcurrencyId,
  });

  factory OcurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$OcurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$OcurrencyModelToJson(this);

  factory OcurrencyModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return OcurrencyModel.fromJson(data);
  }

  Map<String, dynamic> getMapOcurrency({required OcurrencyModel instance}) =>
      <String, dynamic>{
        'id': instance.id,
        'dataRegistro': instance.dataRegistro,
        'dataAt': instance.dataAt,
        'protocolo': instance.protocolo,
        'dataOcorrencia': instance.dataOcorrencia,
        'ocorrencia': instance.ocorrencia,
        'previsao': instance.previsao!.toJson(),
        'responsavel': instance.responsavel!.toJson(),
        'channel': instance.channel!.toJson(),
        'user': instance.user!.toJson(),
        'status': instance.status!.toJson(),
        'cliente': instance.cliente!.getClienteMap(instance: instance.cliente!),
        'fornecedores':
            instance.fornecedores!.map((item) => item.toJson()).toList(),
        'typeOcurrencyId': instance.typeOcurrencyId!.toJson(),
      };

  static OcurrencyModel reset() => OcurrencyModel(
        id: null,
        dataRegistro: null,
        dataAt: null,
        protocolo: null,
        dataOcorrencia: null,
        ocorrencia: null,
        previsao: null,
        responsavel: null,
        channel: null,
        user: null,
        status: null,
        cliente: null,
        fornecedores: null,
        anexos: null,
        comentarios: null,
        typeOcurrencyId: null,
      );
}

@JsonSerializable()
class Previsao {
  String id;
  String name;

  Previsao({required this.id, required this.name});

  factory Previsao.fromJson(Map<String, dynamic> json) =>
      _$PrevisaoFromJson(json);

  Map<String, dynamic> toJson() => _$PrevisaoToJson(this);

  factory Previsao.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return Previsao.fromJson(data);
  }

  static List<Previsao> setPrevisao() {
    List<Previsao> listPrevisao = [];
    listPrevisao.add(Previsao(id: '0', name: 'No prazo'));
    listPrevisao.add(Previsao(id: '1', name: 'Vencendo'));
    listPrevisao.add(Previsao(id: '2', name: 'Vencidas'));
    listPrevisao.add(Previsao(id: '3', name: 'Encerradas'));
    return listPrevisao;
  }
}
