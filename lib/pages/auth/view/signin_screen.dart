import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dartt_maat_v2/common/appname_widget.dart';
import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/config/custom_colors.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';
import 'package:dartt_maat_v2/pages/auth/components/reset_user.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userResult = Get.find<UserController>();
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeWidthWeb = MediaQuery.of(context).size.width * 0.7;
    final sizeHeight = MediaQuery.of(context).size.height * 0.7;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: isMobile
                        ? const EdgeInsets.only(top: 150, bottom: 50)
                        : const EdgeInsets.only(bottom: 50),
                    child: SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                        child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText('Seja bem vindo!'),
                              FadeAnimatedText('Garantir direitos.'),
                              FadeAnimatedText('Formar cidadãos.'),
                              FadeAnimatedText('Em defesa do consumidor.'),
                            ]),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      height: sizeHeight,
                      width: isMobile ? sizeWidth : sizeWidthWeb,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45))),
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
                            controller: emailController,
                            onSaved: ((newValue) =>
                                emailController.text = newValue!),
                            icon: Icons.email,
                            label: 'Email',
                          ),
                          CustomTextField(
                            onSaved: ((newValue) =>
                                senhaController.text = newValue!),
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final result = await userResult.signIn(
                                      usuario: UserModel(
                                          email: emailController.text
                                              .toLowerCase(),
                                          password: senhaController.text));
                                  if (result) {
                                    Get.offNamed(PageRoutes.home);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          // Esqueceu a senha
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () async {
                                  userResult.setSendUser(await showDialog(
                                      context: context,
                                      builder: (_) => ResetForm(
                                            email: emailController.text,
                                          )));
                                  if (userResult.sendUser) {
                                    Get.snackbar('Sucesso!',
                                        "Link de recuperação enviado para o seu email!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.black,
                                        backgroundGradient: linearGreen,
                                        duration: const Duration(seconds: 3),
                                        margin:
                                            const EdgeInsets.only(bottom: 8));
                                  }
                                },
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: CustomColors.customContrastColor,
                                  ),
                                )),
                          ),
                          // Divisor
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text('Ou'),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Botão novo usuário
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  side: BorderSide(
                                    width: 2,
                                    color: CustomColors.customSwatchColor,
                                  )),
                              onPressed: () {
                                Get.toNamed(PageRoutes.signup);
                              },
                              child: const Text(
                                'Primeiro Acesso',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
