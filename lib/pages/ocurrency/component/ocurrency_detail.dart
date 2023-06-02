import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDetails extends StatelessWidget {
  const FormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OcurrencyController>();
    return Form(
        key: controller.formKeyDetails,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Detalhes da reclamação',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Escreva abaixo os detalhes do fato ocorrido.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomTextField(
                  maxLines: null,
                  label: 'Descreva o fato ocorrido',
                  iniValue: controller.ocurrency.ocorrencia,
                  onSaved: (newValue) =>
                      controller.ocurrency.ocorrencia = newValue!,
                  validator: (ocorrencia) {
                    if (ocorrencia!.isEmpty) {
                      return 'O descrição do fato é obrigatório';
                    } else if (ocorrencia.trim().split(' ').length <= 2) {
                      return "Preencha a descrição do fato detalhadamente!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ])));
  }
}
