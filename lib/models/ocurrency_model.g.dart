// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocurrency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcurrencyModel _$OcurrencyModelFromJson(Map<String, dynamic> json) =>
    OcurrencyModel(
      id: json['id'] as String?,
      dataRegistro: json['dataRegistro'] as String?,
      dataAt: json['dataAt'] as String?,
      protocolo: json['protocolo'] as String?,
      dataOcorrencia: json['dataOcorrencia'] as String?,
      ocorrencia: json['ocorrencia'] as String?,
      previsao: json['previsao'] == null
          ? null
          : Previsao.fromJson(json['previsao'] as Map<String, dynamic>),
      responsavel: json['responsavel'] == null
          ? null
          : UserModel.fromJson(json['responsavel'] as Map<String, dynamic>),
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : StatusModel.fromJson(json['status'] as Map<String, dynamic>),
      cliente: json['cliente'] == null
          ? null
          : ClienteModel.fromJson(json['cliente'] as Map<String, dynamic>),
      fornecedores: (json['fornecedores'] as List<dynamic>?)
          ?.map((e) => FornecedorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      anexos: (json['anexos'] as List<dynamic>?)
          ?.map((e) => AnexoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      comentarios: (json['comentarios'] as List<dynamic>?)
          ?.map((e) => ComentarioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeOcurrencyId: json['typeOcurrencyId'] == null
          ? null
          : TypeOcurrencyModel.fromJson(
              json['typeOcurrencyId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OcurrencyModelToJson(OcurrencyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dataRegistro': instance.dataRegistro,
      'dataAt': instance.dataAt,
      'protocolo': instance.protocolo,
      'dataOcorrencia': instance.dataOcorrencia,
      'ocorrencia': instance.ocorrencia,
      'previsao': instance.previsao,
      'responsavel': instance.responsavel!.toJson(),
      'channel': instance.channel!.toJson(),
      'user': instance.user!.toJson(),
      'status': instance.status!.toJson(),
      'cliente': instance.cliente!.toJson(),
      'fornecedores':
          instance.fornecedores!.map((item) => item.toJson()).toList(),
      'anexos': instance.anexos!.map((item) => item.toJson()).toList(),
      'comentarios': instance.comentarios,
      'typeOcurrencyId': instance.typeOcurrencyId!.toJson(),
    };

Previsao _$PrevisaoFromJson(Map<String, dynamic> json) => Previsao(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PrevisaoToJson(Previsao instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
