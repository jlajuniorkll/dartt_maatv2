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
    final utilsServices = UtilsServices();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
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
            GetBuilder<OcurrencyController>(builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CustomTextField(
                        controller: controller.cnpjController,
                        textInputType: TextInputType.number,
                        label: 'Digite o CNPJ',
                        inputFormatters: [utilsServices.cnpjFormatter],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final cnpjUnmasked =
                              utilsServices.cnpjFormatter.getUnmaskedText();
                          var cnpjEncontrado =
                              await controller.fecthCnpj(cnpj: cnpjUnmasked);
                          if (cnpjEncontrado['erro'] == true) {
                            Get.snackbar('Erro!',
                                "Erro ao localizar o CNPJ informado, digite manualmente os dados!",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundGradient: linearBlue,
                                duration: const Duration(seconds: 5),
                                margin: const EdgeInsets.only(bottom: 8));
                            controller.setDataCNPJ();
                          } else {
                            controller.setDataCNPJ(cnpj: cnpjEncontrado);
                          }
                        },
                        child: const SizedBox(
                            height: 42,
                            child: Center(child: Text("Adicionar")))),
                  ),
                ],
              );
            }),
            const Divider(),
            GetBuilder<OcurrencyController>(builder: (controller) {
              return Form(
                key: controller.formKeyFornecedor,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listFornecedor.length,
                    itemBuilder: (_, index) {
                      return NovoFornecedorForm(
                          fornecedor: controller.listFornecedor[index],
                          index: index);
                    }),
              );
            }),
          ],
        ));
  }
}

// ignore: must_be_immutable
class NovoFornecedorForm extends StatelessWidget {
  NovoFornecedorForm(
      {super.key, required this.fornecedor, required this.index});

  FornecedorModel fornecedor;
  int index;
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    TextEditingController fantasiaController =
        TextEditingController(text: '${fornecedor.fantasia}');
    TextEditingController fornecedorController =
        TextEditingController(text: '${fornecedor.razaoSocial}');
    TextEditingController cnpjController =
        TextEditingController(text: '${fornecedor.cnpj}');
    TextEditingController telefoneController =
        TextEditingController(text: '${fornecedor.telefone}');
    TextEditingController emailController =
        TextEditingController(text: '${fornecedor.email}');
    TextEditingController situacaoController =
        TextEditingController(text: '${fornecedor.situacao}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Fornecedor ${index + 1}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        CustomTextField(
          label: 'CNPJ',
          controller: cnpjController,
          textInputType: TextInputType.number,
          inputFormatters: [utilsServices.cnpjFormatter],
          validator: cnpjValidator,
        ),
        CustomTextField(
          label: 'Fantasia',
          controller: fantasiaController,
          validator: fantasiaValidator,
        ),
        CustomTextField(
          label: 'Razão Social',
          controller: fornecedorController,
          validator: fornecedorValidator,
        ),
        CustomTextField(
          label: 'Telefone',
          controller: telefoneController,
          textInputType: TextInputType.number,
          inputFormatters: [utilsServices.foneFormatter],
          validator: phoneValidator,
        ),
        CustomTextField(
          label: 'Email',
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          validator: emailValidator,
        ),
        CustomTextField(
          label: 'Situação',
          controller: situacaoController,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
              onPressed: () {
                Get.find<OcurrencyController>()
                    .setremoveListFornecedor(fornecedor);
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              label: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              )),
        ),
        const Divider(),
      ],
    );
  }
}
