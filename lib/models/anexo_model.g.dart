// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anexo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnexoModel _$AnexoModelFromJson(Map<String, dynamic> json) => AnexoModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$AnexoModelToJson(AnexoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
