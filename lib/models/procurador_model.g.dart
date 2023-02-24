// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurador_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcuradorModel _$ProcuradorModelFromJson(Map<String, dynamic> json) =>
    ProcuradorModel(
      id: json['id'] as String?,
      nome: json['nome'] as String?,
      cpf: json['cpf'] as String?,
      nascimento: json['nascimento'] as String?,
    );

Map<String, dynamic> _$ProcuradorModelToJson(ProcuradorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'nascimento': instance.nascimento,
    };
