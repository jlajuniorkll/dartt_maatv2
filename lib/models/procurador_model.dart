import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'procurador_model.g.dart';

@JsonSerializable()
class ProcuradorModel {
  String? id;
  String? nome;
  String? cpf;
  String? nascimento;

  ProcuradorModel({
    this.id,
    this.nome,
    this.cpf,
    this.nascimento,
  });

  factory ProcuradorModel.fromJson(Map<String, dynamic> json) =>
      _$ProcuradorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProcuradorModelToJson(this);

  factory ProcuradorModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ProcuradorModel.fromJson(data);
  }

  static ProcuradorModel reset() => ProcuradorModel(
        id: null,
        nome: null,
        cpf: null,
        nascimento: null,
      );
}
