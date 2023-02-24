import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'typeocurrency_model.g.dart';

@JsonSerializable()
class TypeOcurrencyModel{
  String? id;
  String? name;
  String? description;
  bool isExpanded;

TypeOcurrencyModel({
  this.id,
  this.name,
  this.description,
  this.isExpanded = false,
});

  factory TypeOcurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$TypeOcurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOcurrencyModelToJson(this);

  factory TypeOcurrencyModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return TypeOcurrencyModel.fromJson(data);
  }

}