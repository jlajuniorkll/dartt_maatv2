import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel{
  String? id;
  String? name;
  String? description;
  int? priority;
  bool isActive;

  StatusModel(
    {this.id,
    this.name,
    this.description,
    this.priority,
    this.isActive = true,}
  );

    factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);

  factory StatusModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return StatusModel.fromJson(data);
  }
}