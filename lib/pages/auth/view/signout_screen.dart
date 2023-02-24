import 'package:dartt_maat_v2/common/appname_widget.dart';
import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:dartt_maat_v2/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final utilServices = UtilsServices();
  final userController = Get.find<UserController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeWidthWeb = MediaQuery.of(context).size.width * 0.7;
    final isMobile = (sizeWidth <= 800.0);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                      top: 10,
                      left: 10,
                      child: SafeArea(
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Cadastre-se!',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          height: 600,
                          width: isMobile ? sizeWidth : sizeWidthWeb,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: AppNameWidget(
                                  greenTitleColor: Colors.black,
                                  redTitleColor: Colors.black,
                                  textSize: 40,
                                ),
                              ),
                              CustomTextField(
                                icon: Icons.person,
                                label: 'Nome',
                                onSaved: ((newValue) =>
                                    userController.usuario.name = newValue),
                                validator: nameValidator
                              ),
                              CustomTextField(
                                  icon: Icons.document_scanner,
                                  onSaved: ((newValue) =>
                                      userController.usuario.cpf = newValue),
                                  inputFormatters: [utilServices.cpfFormatter],
                                  label: 'CPF',
                                  textInputType: TextInputType.number,
                                  validator: cpfValidator),
                              CustomTextField(
                                icon: Icons.email,
                                label: 'Email',
                                onSaved: ((newValue) =>
                                    userController.usuario.email = newValue),
                                autCorrect: false,
                                textInputType: TextInputType.emailAddress,
                                validator: emailValidator,
                              ),
                              CustomTextField(
                                icon: Icons.lock,
                                label: 'Senha',
                                isSecret: true,
                                onSaved: ((newValue) =>
                                    userController.usuario.password = newValue),
                                validator: senhaValidator
                              ),
                              CustomTextField(
                                icon: Icons.lock_outline,
                                label: 'Repita a Senha',
                                isSecret: true,
                                onSaved: ((newValue) => userController
                                    .usuario.confirmPassword = newValue),
                                validator: senhaValidator,
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      userController.setTipoUsuario('Cliente');
                                      _formKey.currentState!.save();
                                      await userController.addUser(signinForm: true);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
