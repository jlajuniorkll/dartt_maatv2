import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:dartt_maat_v2/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormAdress extends StatelessWidget {
  FormAdress({super.key});

  final utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: Get.find<OcurrencyController>().formKeyAdress,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Endereço do cliente',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              GetBuilder<OcurrencyController>(
                builder: (controller) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          !controller.notValidateAdress
                              ? const TextSpan(
                                  text:
                                      'Selecione uma das opções abaixo para preencher o endereço.')
                              : const TextSpan(
                                  text:
                                      'Selecione uma das opções abaixo para preencher o endereço.',
                                  style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              GetBuilder<OcurrencyController>(builder: (controller) {
                return Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: controller.typeLocation != 1
                              ? () {
                                  controller.setTypeLocation(1);
                                  controller.getLocationAuto();
                                }
                              : null,
                          icon: const Icon(Icons.gps_fixed),
                          label: const Text('Localização atual')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: controller.typeLocation != 2
                              ? () async {
                                  controller.setTypeLocation(2);
                                }
                              : null,
                          icon: const Icon(Icons.search),
                          label: const Text('Bucar CEP')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: controller.typeLocation != 3
                              ? () {
                                  controller.setTypeLocation(3);
                                }
                              : null,
                          icon: const Icon(Icons.library_books),
                          label: const Text('Manual')),
                    ),
                  ],
                );
              }),
              GetBuilder<OcurrencyController>(builder: (oc) {
                return oc.typeLocation == 2
                    ? Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            child: const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Digite o CEP e aguarde o sistema preencher automáticamente!'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CustomTextField(
                              label: 'Digite o CEP',
                              textInputType: TextInputType.number,
                              inputFormatters: [utilsServices.cepFormatter],
                              validator: cepValidator,
                              onChanged: (value) async {
                                if (value!.length == 9) {
                                  final cepUnmasked = utilsServices.cepFormatter
                                      .getUnmaskedText();
                                  var cepEncontrado =
                                      await oc.fecthCep(cep: cepUnmasked);
                                  if (cepEncontrado['erro'] == true) {
                                    oc.limpaEnderecoCEP();
                                    Get.snackbar('Erro!',
                                        "Erro ao localizar o CEP informado!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.white,
                                        backgroundGradient: linearBlue,
                                        duration: const Duration(seconds: 3),
                                        margin:
                                            const EdgeInsets.only(bottom: 8));
                                  } else {
                                    oc.setEnderecoCEP(cepEncontrado);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    : oc.logradouroController.text != ''
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CustomTextField(
                              controller: oc.cepController,
                              label: 'Digite o CEP',
                              textInputType: TextInputType.number,
                              inputFormatters: [utilsServices.cepFormatter],
                              validator: cepValidator,
                            ),
                          )
                        : const SizedBox();
              }),
              GetBuilder<OcurrencyController>(
                builder: (controller) {
                  return controller.cepController.text != ''
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomTextField(
                                  controller: controller.numeroController,
                                  label: 'Número',
                                  textInputType: TextInputType.number,
                                  validator: numeroValidator),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomTextField(
                                  controller: controller.logradouroController,
                                  label: 'Logradouro',
                                  validator: logradouroValidator),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomTextField(
                                  controller: controller.bairroController,
                                  label: 'Bairro',
                                  validator: bairroValidator),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomTextField(
                                  controller: controller.cidadeController,
                                  label: 'Cidade',
                                  validator: cidadeValidator),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomTextField(
                                  controller: controller.estadoController,
                                  label: 'Estado',
                                  validator: estadoValidator),
                            ),
                          ],
                        )
                      : const Divider();
                },
              )
            ])));
  }
}
