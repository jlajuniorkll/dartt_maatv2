import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_adress.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_anexos.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_description.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_detail.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_finish.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_fornecedor.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/pagecontroller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_client.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_header_interno.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcurrencyFormScreen extends StatefulWidget {
  const OcurrencyFormScreen({super.key});

  @override
  State<OcurrencyFormScreen> createState() => _OcurrencyFormScreenState();
}

class _OcurrencyFormScreenState extends State<OcurrencyFormScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<PageManager>();
  final controllerOcurrency = Get.find<OcurrencyController>();
  final int qtdPages = 7;

  @override
  void initState() {
    super.initState();
    controller.tabController = TabController(length: qtdPages, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .7;
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: isMobile ? widhtMobile : widhtWeb,
          child: Dialog(
            insetPadding:
                isMobile ? const EdgeInsets.symmetric(horizontal: 8) : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                              controller.setPage(0);
                              if (controllerOcurrency.ocurrency.id != null) {
                                controllerOcurrency.clearAll(
                                    deleteAnexos: false);
                              }
                            },
                            icon: const Icon(Icons.close),
                          )),
                    ),
                    if (controllerOcurrency.ocurrency.id == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                controller.setPage(0);
                                controllerOcurrency.clearAll(
                                    deleteAnexos:
                                        controllerOcurrency.ocurrency.id ==
                                            null);
                              },
                              icon: const Icon(Icons.restart_alt),
                            )),
                      ),
                  ],
                ),
                ExpandablePageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: [
                    const HeaderFormInterno(),
                    FormClient(),
                    FormAdress(),
                    const FormFornecedor(),
                    FormDescription(),
                    const FormDetails(),
                    const FormAnexos(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      controller.page > 0
                          ? SizedBox(
                              height: 32,
                              width: 100,
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    controller.setPage(controller.page - 1);
                                  });
                                },
                                label: const Text('Voltar'),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                            )
                          : const SizedBox(
                              height: 32,
                              width: 100,
                            ),
                      Expanded(
                        child: Center(
                          child: TabPageSelector(
                            controller: controller.tabController,
                            color: const Color(0xFF00CCFF),
                            selectedColor: const Color(0xFF3366FF),
                            borderStyle: BorderStyle.none,
                          ),
                        ),
                      ),
                      controller.page < (qtdPages - 1)
                          ? SizedBox(
                              height: 32,
                              width: 100,
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    validPageController();
                                  });
                                },
                                label: const Text('Avançar'),
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  height: 32,
                                  child: GetBuilder<OcurrencyController>(
                                      builder: (controllerOcurrency) {
                                    return ElevatedButton(
                                      onPressed: controllerOcurrency
                                              .listAnexos.isNotEmpty
                                          ? () {
                                              Get.back();
                                              Get.dialog(
                                                  const OcurrencyFinish());
                                              controller.setPage(0);
                                              controllerOcurrency
                                                  .finalizarReclamacao();
                                              controllerOcurrency.update();
                                            }
                                          : null,
                                      child: controllerOcurrency.ocurrency.id !=
                                              null
                                          ? const Text('Atualizar')
                                          : const Text('Finalizar'),
                                    );
                                  })),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validPageController() {
    switch (controller.page) {
      case 0:
        if (controllerOcurrency.formKeyHeader.currentState!.validate()) {
          controllerOcurrency.formKeyHeader.currentState!.save();
          controller.setPage(controller.page + 1);
        }
        break;
      case 1:
        if (controllerOcurrency.formKeyClient.currentState!.validate()) {
          controllerOcurrency.formKeyClient.currentState!.save();
          controller.setPage(controller.page + 1);
        }
        break;
      case 2:
        if (controllerOcurrency.formKeyAdress.currentState!.validate() &&
            controllerOcurrency.cepController.text != '') {
          controllerOcurrency.formKeyAdress.currentState!.save();
          controller.setPage(controller.page + 1);
        } else {
          controllerOcurrency.setNotValidateAdress(true);
        }
        break;
      case 3:
        if (controllerOcurrency.formKeyFornecedor.currentState!.validate()) {
          controllerOcurrency.formKeyFornecedor.currentState!.save();
          controller.setPage(controller.page + 1);
        }

        break;
      case 4:
        if (Get.find<TypeOcurrencyController>().isTypeSelected != '') {
          controllerOcurrency.formKeyDescription.currentState!.save();
          controller.setPage(controller.page + 1);
        } else {
          Get.snackbar(
            "Atenção",
            "É obrigatório selecionar um tipo de reclamação.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            borderColor: Colors.red,
            borderRadius: 0,
            borderWidth: 2,
            barBlur: 0,
          );
        }
        break;
      case 5:
        if (controllerOcurrency.formKeyDetails.currentState!.validate()) {
          controllerOcurrency.formKeyDetails.currentState!.save();
          controller.setPage(controller.page + 1);
        }
        break;
    }
  }
}
