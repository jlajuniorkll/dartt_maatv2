import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderFormInterno extends StatelessWidget {
  const HeaderFormInterno({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OcurrencyController>();
    final userController = Get.find<UserController>();
    final statusController = Get.find<StatusController>();
    final channelController = Get.find<ChannelController>();
    final FocusNode focusNode = FocusNode();
    return Form(
      key: controller.formKeyHeader,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.ocurrency.id != null
              ? Text(
                  'Protocolo: ${controller.ocurrency.protocolo}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                )
              : const Text(
                  'Reclamação',
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
                          'Preencha os dados iniciais para fazer a sua reclamação.'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                CustomTextField(
                    label: "Usuário",
                    iniValue: controller.ocurrency.user?.name ??
                        userController.usuarioLogado?.name ??
                        "Não Logado",
                    isInActive: true),
                CustomTextField(
                    label: "Data Atual/Registro",
                    iniValue: controller.ocurrency.dataRegistro ??
                        controller.getDataHoraAtual(),
                    onSaved: (newDataAt) =>
                        controller.ocurrency.dataRegistro = newDataAt,
                    isInActive: true),
                GetBuilder<OcurrencyController>(
                  builder: (controller) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<StatusModel>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.done),
                            isDense: true,
                            labelText: 'Status',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          value: controller.ocurrency.status,
                          onChanged: (StatusModel? newValue) {
                            controller.setStatusOcurrency(newValue!);
                          },
                          onSaved: (newValue) {
                            controller.setStatusOcurrency(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Escolha uma opção';
                            }
                            return null;
                          },
                          items: statusController.selectStatus
                              .map<DropdownMenuItem<StatusModel>>(
                                  (StatusModel e) {
                            return DropdownMenuItem<StatusModel>(
                              value: e,
                              child: Text(e.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<OcurrencyController>(
                  builder: (controller) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<ChannelModel>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.call),
                            isDense: true,
                            labelText: 'Canal Atendimento',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          value: controller.ocurrency.channel,
                          onChanged: (ChannelModel? newValue) {
                            controller.setChannelOcurrency(newValue!);
                          },
                          onSaved: (newValue) {
                            controller.setChannelOcurrency(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Escolha uma opção';
                            }
                            return null;
                          },
                          items: channelController.selectChannel
                              .map<DropdownMenuItem<ChannelModel>>(
                                  (ChannelModel e) {
                            return DropdownMenuItem<ChannelModel>(
                              value: e,
                              child: Text(e.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<OcurrencyController>(
                  builder: (controller) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<UserModel>(
                          focusNode: focusNode,
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            isDense: true,
                            labelText: 'Responsável',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          value: controller.ocurrency.responsavel,
                          onChanged: (UserModel? newValue) {
                            controller.setUserOcurrency(newValue!);
                            focusNode.nextFocus();
                          },
                          onSaved: (newValue) {
                            controller.setUserOcurrency(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Escolha uma opção';
                            }
                            return null;
                          },
                          items: userController.selectResponsavel
                              .map<DropdownMenuItem<UserModel>>((UserModel e) {
                            return DropdownMenuItem<UserModel>(
                              value: e,
                              child: Text(e.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GetBuilder<OcurrencyController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now())
                        .then((value) {
                      controller.setDataFato(value!);
                    });
                  },
                  child: IgnorePointer(
                    child: CustomTextField(
                      controller: controller.dataOcorrenciaController,
                      label: "Data da compra/fato",
                      validator: (dt) {
                        if (dt!.isEmpty) {
                          return 'A data do fato é obrigatório';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
