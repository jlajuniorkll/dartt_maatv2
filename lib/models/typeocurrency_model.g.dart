// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeocurrency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOcurrencyModel _$TypeOcurrencyModelFromJson(Map<String, dynamic> json) =>
    TypeOcurrencyModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$TypeOcurrencyModelToJson(TypeOcurrencyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isExpanded': instance.isExpanded,
    };
