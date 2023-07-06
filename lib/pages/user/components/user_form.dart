import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserForm extends StatefulWidget {
  UserForm({Key? key, this.userReceived}) : super(key: key);

  UserModel? userReceived;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  final utilsServices = UtilsServices();

  @override
  void initState() {
    super.initState();
    verificaReceived();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .5;
    return Center(
      child: SingleChildScrollView(
          child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          width: isMobile < 800 ? widhtMobile : widhtWeb,
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.close),
                                )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                widget.userReceived != null
                                    ? 'Atualizar usuário'
                                    : 'Cadastrar usuário',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Text(
                          'Tipo de Usuário:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text('Selecione o tipo...'),
                          value: userController.tipoUsuarioSelecionado,
                          elevation: 16,
                          borderRadius: BorderRadius.circular(18),
                          alignment: AlignmentDirectional.center,
                          onChanged: (String? newValue) {
                            setState(() {
                              userController.tipoUsuarioSelecionado = newValue!;
                            });
                          },
                          items: userController.tipoUsuario
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        label: 'Nome Completo',
                        iniValue: userController.usuario.name,
                        onSaved: ((newValue) =>
                            userController.usuario.name = newValue),
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'O nome é obrigatório';
                          } else if (name.trim().split(' ').length <= 1) {
                            return "Preencha seu nome completo!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        iniValue: userController.usuario.cpf,
                        onSaved: ((newValue) =>
                            userController.usuario.cpf = newValue),
                        textInputType: TextInputType.number,
                        label: 'CPF',
                        inputFormatters: [utilsServices.cpfFormatter],
                        validator: (cpf) {
                          if (cpf!.isEmpty) {
                            return 'O CPF é obrigatório';
                          } else if (!cpf.isCpf) {
                            return 'CPF é inválido';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        iniValue: userController.usuario.email,
                        onSaved: ((newValue) =>
                            userController.usuario.email = newValue),
                        autCorrect: false,
                        label: 'E-mail',
                        textInputType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return 'E-mail Obrigatório';
                          } else if (!email.isEmail) {
                            return 'E-mail Inválido';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        isSecret: true,
                        iniValue: userController.usuario.password,
                        onSaved: ((newValue) =>
                            userController.usuario.password = newValue),
                        autCorrect: false,
                        label: 'Senha',
                        validator: (senha) {
                          if (senha!.isEmpty) {
                            return 'Senha é obrigatória';
                          } else if (senha.length <= 4) {
                            return 'Senha deve ter mínimo 4 caracteres';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        isSecret: true,
                        iniValue: userController.usuario.confirmPassword,
                        onSaved: ((newValue) =>
                            userController.usuario.confirmPassword = newValue),
                        autCorrect: false,
                        label: 'Repita a Senha',
                        validator: (senha) {
                          if (senha!.isEmpty) {
                            return 'Senha é obrigatória';
                          } else if (senha.length <= 4) {
                            return 'Senha deve ter mínimo 4 caracteres';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                          height: 44,
                          child: widget.userReceived != null
                              ? ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Get.back();
                                      await userController.updateUser();
                                      Get.snackbar('Atualizado',
                                          'Usuário ${userController.usuario.name} atualizado com sucesso!',
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.black,
                                          backgroundGradient: linearGreen,
                                          duration: const Duration(seconds: 3),
                                          margin:
                                              const EdgeInsets.only(bottom: 8));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                  child: const Text(
                                    'Atualizar',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Get.back();
                                      await userController.addUser();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                )),
                    ]),
              )),
        ),
      )),
    );
  }

  void verificaReceived() {
    if (widget.userReceived != null) {
      userController.usuario = widget.userReceived!;
      userController.tipoUsuarioSelecionado = widget.userReceived!.typeUser;
    } else {
      userController.usuario = UserModel();
      userController.tipoUsuarioSelecionado = "Administrador";
    }
  }
}
