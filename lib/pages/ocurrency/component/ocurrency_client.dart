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
    final controller = Get.find<OcurrencyController>();
    return Form(
      key: controller.formKeyClient,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Text(
              'Dados do Consumidor',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Preencha os dados do cliente reclamante.'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomTextField(
                label: 'Nome completo',
                validator: nameValidator,
                iniValue: controller.cliente.nome ?? '',
                onSaved: ((newValue) => controller.cliente.nome = newValue),
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
                      validator: cpfValidator,
                      iniValue: controller.cliente.cpf ?? '',
                      onSaved: ((newValue) =>
                          controller.cliente.cpf = newValue),
                    ),
                  ),
                ),
                Expanded(child:
                    GetBuilder<OcurrencyController>(builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
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
                          onSaved: ((newValue) =>
                              controller.cliente.nascimento = newValue),
                        ),
                      ),
                    ),
                  );
                })),
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
                      validator: phoneValidator,
                      iniValue: controller.cliente.foneWhats ?? '',
                      onSaved: ((newValue) =>
                          controller.cliente.foneWhats = newValue),
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
                      iniValue: controller.cliente.telefone ?? '',
                      onSaved: ((newValue) =>
                          controller.cliente.telefone = newValue),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomTextField(
                textInputType: TextInputType.emailAddress,
                label: 'E-mail',
                validator: emailValidator,
                iniValue: controller.cliente.email ?? '',
                onSaved: ((newValue) => controller.cliente.email = newValue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Possui procurador?'),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GetBuilder<OcurrencyController>(
                      builder: (controller) {
                        return Switch(
                            value: controller.whithProcurador,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              controller.setWhithProcurador(value);
                            });
                      },
                    )),
              ],
            ),
            GetBuilder<OcurrencyController>(
              builder: (controller) {
                if (controller.whithProcurador) {
                  return FormProcurador();
                } else {
                  return const SizedBox();
                }
              },
            )
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
    return Column(
      children: [
        const Divider(),
        const Text(
          'Dados do Procurador',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomTextField(
            label: 'Nome procurador',
            validator: nameValidator,
            iniValue: controller.procurador.nome ?? '',
            onSaved: ((newValue) => controller.procurador.nome = newValue!),
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
                  validator: cpfValidator,
                  iniValue: controller.procurador.cpf ?? '',
                  onSaved: ((newValue) =>
                      controller.procurador.cpf = newValue!),
                ),
              ),
            ),
            Expanded(child: GetBuilder<OcurrencyController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
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
                        onSaved: ((newValue) =>
                            controller.procurador.nascimento = newValue!),
                      ),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ],
    );
  }
}
