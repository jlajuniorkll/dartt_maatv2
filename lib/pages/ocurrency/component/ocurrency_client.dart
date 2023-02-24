import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:dartt_maat_v2/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormClient extends StatelessWidget {
 FormClient({super.key});

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<OcurrencyController>().formKeyClient,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Text(
              'Dados do Consumidor',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomTextField(
                label: 'Nome completo',
                validator: nameValidator
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomTextField(
                      textInputType: TextInputType.number,
                      inputFormatters: [utilsServices.cpfFormatter],
                      label: 'CPF',
                      validator: cpfValidator
                    ),
                  ),
                ),
                Expanded(
                  child: GetBuilder<OcurrencyController>(builder: (controller){
                    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now())
                          .then((value) {
                        controller.setDataNascimento(value!);
                      }),
                      child: IgnorePointer(
                        child: CustomTextField(
                          controller: controller.dataNascimentoController,
                          label: 'Data de Nascimento',
                          validator: idadeValidator,
                        ),
                      ),
                    ),
                  );
                  })
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomTextField(
                      textInputType: TextInputType.phone,
                      inputFormatters: [utilsServices.foneFormatter],
                      label: 'DDD + Telefone/Whatsapp',
                      validator: phoneValidator
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomTextField(
                      textInputType: TextInputType.phone,
                      label: 'Telefone (Opcional)',
                      inputFormatters: [utilsServices.foneFormatter],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomTextField(
                textInputType: TextInputType.emailAddress,
                label: 'E-mail',
                validator: emailValidator
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Possui procurador?'),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GetBuilder<OcurrencyController>(builder: (controller){                  
                    return Switch(
                      value: controller.whithProcurador,
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                          controller.setWhithProcurador(value);
                      });
                  },)
                ),
              ],
            ),
            GetBuilder<OcurrencyController>(builder: (controller){
              if (controller.whithProcurador){
                return FormProcurador();
              } else {
                return const SizedBox();
              }
            },)
          ],
        ),
      ),
    );
  }
}

class FormProcurador extends StatelessWidget {
 FormProcurador({super.key});

  final controller = Get.find<OcurrencyController>();
  final utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyProcurador,
      child: Column(
        children: [
          const Divider(),
          const Text(
            'Dados do Procurador',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomTextField(
              label: 'Nome procurador',
              validator: nameValidator
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomTextField(
                    textInputType: TextInputType.number,
                    label: 'CPF Procurador',
                    inputFormatters: [utilsServices.cpfFormatter],
                    validator: cpfValidator
                  ),
                ),
              ),
              Expanded(
                child: GetBuilder<OcurrencyController>(builder: (controller){
                  return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: InkWell(
                    onTap: () => showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now())
                        .then((value) {
                          controller.setDataNascProcurador(value!);
                        }),
                    child: IgnorePointer(
                      child: CustomTextField(
                        controller: controller.dataNascProcuradorController,
                        label: 'Data de Nasc. Procurador',
                        validator: idadeValidator,
                      ),
                    ),
                  ),
                );
                },)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
