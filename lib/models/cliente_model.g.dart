// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClienteModel _$ClienteModelFromJson(Map<String, dynamic> json) => ClienteModel(
      id: json['id'] as String?,
      nome: json['nome'] as String?,
      cpf: json['cpf'] as String?,
      nascimento: json['nascimento'] as String?,
      foneWhats: json['foneWhats'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      cep: json['cep'] as String?,
      numero: json['numero'] as String?,
      logradouro: json['logradouro'] as String?,
      bairro: json['bairro'] as String?,
      cidade: json['cidade'] as String?,
      estado: json['estado'] as String?,
      procurador: json['procurador'] == null
          ? null
          : ProcuradorModel.fromJson(
              json['procurador'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClienteModelToJson(ClienteModel instance) =>
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
      'procurador': instance.procurador,
    };
