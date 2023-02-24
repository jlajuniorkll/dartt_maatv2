import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comentario_model.g.dart';

@JsonSerializable()
class ComentarioModel {
  String? id;
  String? description;
  UserModel? usuario;
  String? dataComentario;

  ComentarioModel({this.id, this.description, this.usuario, this.dataComentario});

  factory ComentarioModel.fromJson(Map<String, dynamic> json) =>
      _$ComentarioModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComentarioModelToJson(this);

  factory ComentarioModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ComentarioModel.fromJson(data);
  }
}
