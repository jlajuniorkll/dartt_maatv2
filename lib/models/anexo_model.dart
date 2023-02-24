import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anexo_model.g.dart';

@JsonSerializable()
class AnexoModel {
  String? id;
  String? name;
  String? url;

  AnexoModel({this.name, this.url});

  factory AnexoModel.fromJson(Map<String, dynamic> json) =>
      _$AnexoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnexoModelToJson(this);

  factory AnexoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return AnexoModel.fromJson(data);
  }
}
