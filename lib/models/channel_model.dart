import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  String? id;
  String? name;
  String? description;

  ChannelModel({this.id, this.name, this.description});

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);

  factory ChannelModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ChannelModel.fromJson(data);
  }

  static ChannelModel reset() =>
      ChannelModel(id: null, name: null, description: null);
}
