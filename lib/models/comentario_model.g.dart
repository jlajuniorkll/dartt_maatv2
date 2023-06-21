// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comentario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComentarioModel _$ComentarioModelFromJson(Map<String, dynamic> json) =>
    ComentarioModel(
      id: json['id'] as String?,
      description: json['description'] as String?,
      usuario: json['usuario'] == null
          ? null
          : UserModel.fromJson(json['usuario'] as Map<String, dynamic>),
      dataComentario: json['dataComentario'] as String?,
    );

Map<String, dynamic> _$ComentarioModelToJson(ComentarioModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'usuario': instance.usuario!.toJson(),
      'dataComentario': instance.dataComentario,
    };
