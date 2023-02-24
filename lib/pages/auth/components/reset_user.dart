import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/custom_colors.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:dartt_maat_v2/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetForm extends StatelessWidget {
  final emailController = TextEditingController();
  ResetForm({required String email, Key? key}) : super(key: key) {
    emailController.text = email;
  }

  final _formFieldKey = GlobalKey<FormFieldState>();
  final userResult = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeWidthWeb = MediaQuery.of(context).size.width * 0.5;
    final isMobile = (sizeWidth <= 800.0);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: isMobile ? sizeWidth : sizeWidthWeb,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titulo
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Recuperação de senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Descrição
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      'Digite seu email para recuperar sua senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),

                  // Campo de email
                  CustomTextField(
                    controller: emailController,
                    icon: Icons.email,
                    label: 'Email',
                    validator: emailValidator,
                    formFieldKey: _formFieldKey,
                  ),

                  // Confirmar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(
                        width: 2,
                        color: CustomColors.customSwatchColor,
                      ),
                    ),
                    onPressed: () {
                      if (_formFieldKey.currentState!.validate()) {
                        userResult.resetUser(emailController.text);
                        Get.back(result: true);
                      }
                    },
                    child: const Text(
                      'Recuperar',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Get.back(result: false);
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
