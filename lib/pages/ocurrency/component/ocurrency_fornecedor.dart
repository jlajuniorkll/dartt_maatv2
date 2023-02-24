import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/fornecedor_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:dartt_maat_v2/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormFornecedor extends StatelessWidget {
  const FormFornecedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GetBuilder<OcurrencyController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Dados do Fornecedor',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'Digite o CNPJ para preencher automaticamente os dados do fornecedor.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listFornecedor.length,
                    itemBuilder: (_, index) {
                      return NewFormFornecedor(index: index);
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                      onPressed: () {
                        controller
                            .setAddListFornecedor();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar outro CNPJ')),
                ),
              ],
            );
          },
        ));
  }
}

class NewFormFornecedor extends StatelessWidget {
  const NewFormFornecedor({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final utilsServices = UtilsServices();
    return GetBuilder<OcurrencyController>(builder: (controller) {
      return Form(
        key: controller.formKeyFornecedor[index],
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomTextField(
              controller: controller.cnpjController[index],
              textInputType: TextInputType.number,
              label: 'CNPJ',
              inputFormatters: [utilsServices.cnpjFormatter],
              validator: cnpjValidator,
              onChanged: (value) async {
                if (value!.length == 18) {
                  final cnpjUnmasked =
                      utilsServices.cnpjFormatter.getUnmaskedText();
                  var cnpjEncontrado = await controller.fecthCnpj(cnpj: cnpjUnmasked);
                  if (cnpjEncontrado['erro'] == true) {
                    Get.snackbar('Erro!', "Erro ao localizar o CNPJ informado!",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundGradient: linearBlue,
                        duration: const Duration(seconds: 3),
                        margin: const EdgeInsets.only(bottom: 8));
                  } else {
                    controller.setEnderecoCNPJ(cnpjEncontrado, index);
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomTextField(
                controller: controller.fantasiaController[index],
                label: 'Nome Fantasia',
                validator: fantasiaValidator),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomTextField(
                controller: controller.fornecedorController[index],
                label: 'Fornecedor',
                validator: fornecedorValidator),
          ),
          controller.listFornecedor.isNotEmpty
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                      onPressed: () {
                        controller.setremoveListFornecedor(controller.listFornecedor[index]);
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text('Remover CNPJ')),
                )
              : const SizedBox(),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
        ]),
      );
    });
  }
}
