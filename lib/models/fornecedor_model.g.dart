// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorModel _$FornecedorModelFromJson(Map<String, dynamic> json) =>
    FornecedorModel(
      id: json['id'] as String?,
      cnpj: json['cnpj'] as String?,
      fantasia: json['fantasia'] as String?,
      razaoSocial: json['razaoSocial'] as String?,
      situacao: json['situacao'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$FornecedorModelToJson(FornecedorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cnpj': instance.cnpj,
      'fantasia': instance.fantasia,
      'razaoSocial': instance.razaoSocial,
      'situacao': instance.situacao,
      'telefone': instance.telefone,
      'email': instance.email,
    };
