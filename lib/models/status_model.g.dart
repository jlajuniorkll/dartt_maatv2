// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'priority': instance.priority,
      'isActive': instance.isActive,
    };
