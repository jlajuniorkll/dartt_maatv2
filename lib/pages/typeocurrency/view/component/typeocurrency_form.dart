import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TypeOcurrencyForm extends StatelessWidget {
  TypeOcurrencyForm({Key? key, this.typeOcurrencyReceived}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final typeocurrencyController = Get.find<TypeOcurrencyController>();
  TypeOcurrencyModel? typeOcurrencyReceived;

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .5;
    verificaReceived();
    return Center(
      child: SizedBox(
        width: isMobile < 800 ? widhtMobile : widhtWeb,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsetsDirectional.all(16),
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          typeOcurrencyReceived != null
                              ? 'Atualizar tipo de ocorrência'
                              : 'Cadastrar tipo de ocorrência',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        )),
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    label: 'Nome do tipo',
                    iniValue: typeocurrencyController.typeOcurrency.name,
                    onSaved: ((newValue) =>
                        typeocurrencyController.typeOcurrency.name = newValue),
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'O nome é obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    iniValue: typeocurrencyController.typeOcurrency.description,
                    onSaved: ((newValue) => typeocurrencyController
                        .typeOcurrency.description = newValue),
                    label: 'Descrição do tipo',
                    maxLines: null,
                    validator: (desc) {
                      if (desc!.isEmpty) {
                        return 'A descrição é obrigatória';
                      } else if (desc.trim().split(' ').length <= 1) {
                        return 'Descrição muito curta';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                      height: 44,
                      child: typeOcurrencyReceived != null
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Get.back();
                                  await typeocurrencyController
                                      .updateTypeOcurrency();
                                  Get.snackbar('Atualizado',
                                      'Tipo de ocorrência ${typeocurrencyController.typeOcurrency.name} atualizado com sucesso!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.black,
                                      backgroundGradient: linearGreen,
                                      duration: const Duration(seconds: 3),
                                      margin: const EdgeInsets.only(bottom: 8));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
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
                                  await typeocurrencyController
                                      .addTypeOcurrency();
                                  Get.snackbar('Cadastrado',
                                      'Tipo de ocorrência ${typeocurrencyController.typeOcurrency.name} cadastrado com sucesso!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.black,
                                      backgroundGradient: linearGreen,
                                      duration: const Duration(seconds: 3),
                                      margin: const EdgeInsets.only(bottom: 8));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            )),
                ],
              )),
        ),
      ),
    );
  }

  void verificaReceived() {
    if (typeOcurrencyReceived != null) {
      typeocurrencyController.typeOcurrency = typeOcurrencyReceived!;
    } else {
      typeocurrencyController.typeOcurrency = TypeOcurrencyModel();
    }
  }
}
