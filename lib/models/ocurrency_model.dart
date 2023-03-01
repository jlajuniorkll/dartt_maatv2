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
}
