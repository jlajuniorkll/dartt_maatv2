import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? name;
  String? cpf;
  String? email;
  String? password;
  String? confirmPassword;
  String? typeUser;

  UserModel({
    this.id,
    this.name,
    this.cpf,
    this.email,
    this.typeUser,
    this.password,
    this.confirmPassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return UserModel.fromJson(data);
  }

  static UserModel reset() => UserModel(
        id: null,
        name: null,
        cpf: null,
        email: null,
        typeUser: null,
        password: null,
        confirmPassword: null,
      );
}
