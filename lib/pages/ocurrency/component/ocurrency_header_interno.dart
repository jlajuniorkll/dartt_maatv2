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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("Usuário: ",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    GetBuilder<UserController>(builder: (userController) {
                      return Text(
                          userController.usuarioLogado!.name ?? "Não logado");
                    }),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("Data Atual/Registro: ",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Text(controller.getDataHoraAtual()),
                  ],
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text("Status: ",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text("Não carregado"),
                      ],
                    ),
                  ),
                ),
                GetBuilder<ChannelController>(
                  builder: (channelController) {
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text("Canal: ",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<ChannelModel>(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                GetBuilder<UserController>(
                  builder: (userManager) {
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text("Responsável: ",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<UserModel>(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name!),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          GetBuilder<OcurrencyController>(
            builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
