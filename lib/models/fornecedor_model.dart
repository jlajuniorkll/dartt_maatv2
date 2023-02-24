import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fornecedor_model.g.dart';

@JsonSerializable()
class FornecedorModel {
  String? id;
  String? cnpj;
  String? fantasia;
  String? razaoSocial;
  String? situacao;
  String? telefone;
  String? email;

  FornecedorModel({
    this.id,
    this.cnpj,
    this.fantasia,
    this.razaoSocial,
    this.situacao,
    this.telefone,
    this.email
  });

  factory FornecedorModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FornecedorModelToJson(this);

  factory FornecedorModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return FornecedorModel.fromJson(data);
  }
}
