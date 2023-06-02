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

  ClienteModel(
      {this.id,
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
      this.procurador});

  factory ClienteModel.fromJson(Map<String, dynamic> json) =>
      _$ClienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteModelToJson(this);

  factory ClienteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ClienteModel.fromJson(data);
  }

  Map<String, dynamic> getClienteMap({required ClienteModel instance}) =>
      <String, dynamic>{
        'id': instance.id,
        'nome': instance.nome,
        'cpf': instance.cpf,
        'nascimento': instance.nascimento,
        'foneWhats': instance.foneWhats,
        'telefone': instance.telefone,
        'email': instance.email,
        'cep': instance.cep,
        'numero': instance.numero,
        'logradouro': instance.logradouro,
        'bairro': instance.bairro,
        'cidade': instance.cidade,
        'estado': instance.estado,
        'procurador': instance.procurador!.toJson()
      };

  static ClienteModel reset() => ClienteModel(
      id: null,
      nome: null,
      cpf: null,
      nascimento: null,
      foneWhats: null,
      telefone: null,
      email: null,
      cep: null,
      numero: null,
      logradouro: null,
      bairro: null,
      cidade: null,
      estado: null,
      procurador:
          ProcuradorModel(id: null, nome: null, cpf: null, nascimento: null));
}
