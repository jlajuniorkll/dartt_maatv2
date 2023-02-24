import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StatusForm extends StatelessWidget {
  StatusForm({Key? key, this.statusReceived}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final statusController = Get.find<StatusController>();
  StatusModel? statusReceived;

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
                          statusReceived != null
                              ? 'Atualizar situação de atendimento'
                              : 'Cadastrar situação de atendimento',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ))
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    iniValue: statusController.status.name,
                    onSaved: ((newValue) =>
                        statusController.status.name = newValue),
                    label: 'Nome da situação',
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'O nome é obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    iniValue: statusController.status.description,
                    onSaved: ((newValue) =>
                        statusController.status.description = newValue),
                    label: 'Descrição da situação',
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
                      child: statusReceived != null
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Get.back();
                                  await statusController.updateStatus();
                                  Get.snackbar('Atualizado',
                                      'Situação ${statusController.status.name} atualizada com sucesso!',
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
                                  await statusController.addStatus();
                                  Get.snackbar('Cadastrado',
                                      'Situação ${statusController.status.name} cadastrado com sucesso!',
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
    if (statusReceived != null) {
      statusController.status = statusReceived!;
    } else {
      statusController.status = StatusModel();
    }
  }
}
