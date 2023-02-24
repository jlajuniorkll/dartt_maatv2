import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/procurador_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cliente_model.g.dart';

@JsonSerializable()
class ClienteModel {
  String? id;
  String? nome;
  String? cpf;
  String? nascimento;
  String? foneWhats;
  String? telefone;
  String? email;
  String? cep;
  String? numero;
  String? logradouro;
  String? bairro;
  String? cidade;
  String? estado;
  ProcuradorModel? procurador;


  ClienteModel({
    this.id,
    this.nome,
    this.cpf,
    this.nascimento,
    this.foneWhats,
    this.telefone,
    this.email,
    this.cep,
    this.numero,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.estado,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) =>
      _$ClienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteModelToJson(this);

  factory ClienteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ClienteModel.fromJson(data);
  }
}
