import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderFormInterno extends StatelessWidget {
  const HeaderFormInterno({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OcurrencyController>();
    final userController = Get.find<UserController>();
    return Form(
      key: controller.formKeyHeader,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reclamação',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                CustomTextField(
                    label: "Usuário",
                    iniValue:
                        userController.usuarioLogado!.name ?? "Não logado",
                    isInActive: true),
                CustomTextField(
                    label: "Data Atual/Registro",
                    iniValue: controller.getDataHoraAtual(),
                    isInActive: true),
                const CustomTextField(
                    label: "Status",
                    iniValue: "Não carregado",
                    isInActive: true),
                GetBuilder<ChannelController>(
                  builder: (channelController) {
                    return Container(
                      height: 42,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey),
                          borderRadius:
                              BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<ChannelModel>(
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.0),
                              child:
                                  Text('Selecione o canal de atendimento...'),
                            ),
                            isDense: true,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(18),
                            value: channelController.channnelSelected,
                            onChanged: (ChannelModel? newValue) {
                              channelController.setChannelSelected(newValue!);
                            },
                            items: channelController.selectChannel
                                .map<DropdownMenuItem<ChannelModel>>(
                                    (ChannelModel e) {
                              return DropdownMenuItem<ChannelModel>(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Text(e.name!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<UserController>(
                  builder: (userManager) {
                    return Container(
                      height: 42,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<UserModel>(
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.0),
                              child: Text('Selecione o responsável...'),
                            ),
                            isDense: true,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(18),
                            value: userManager.responsavelSelected,
                            onChanged: (UserModel? newValue) {
                              userManager.setResponsavelSelected(newValue!);
                            },
                            items: userManager.selectResponsavel
                                .map<DropdownMenuItem<UserModel>>(
                                    (UserModel e) {
                              return DropdownMenuItem<UserModel>(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Text(e.name!),
                                ),
                              );
                            }).toList(),
                          ),
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
