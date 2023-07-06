import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChannelForm extends StatelessWidget {
  ChannelForm({Key? key, this.channelReceived}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final channelController = Get.find<ChannelController>();
  ChannelModel? channelReceived;

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .5;
    verificaReceived();
    return Center(
      child: SingleChildScrollView(
          child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          width: isMobile < 800 ? widhtMobile : widhtWeb,
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.close),
                            )),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            channelReceived != null
                                ? 'Atualizar canal de atendimento'
                                : 'Cadastrar canal de atendimento',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          )),
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      iniValue: channelController.channel.name,
                      onSaved: ((newValue) =>
                          channelController.channel.name = newValue),
                      label: 'Nome do canal',
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'O nome é obrigatório';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextField(
                      iniValue: channelController.channel.description,
                      onSaved: ((newValue) =>
                          channelController.channel.description = newValue),
                      label: 'Descrição do canal',
                      validator: (desc) {
                        if (desc!.isEmpty) {
                          return 'A descrição é obrigatória';
                        } else if (desc.trim().split(' ').length <= 1) {
                          return 'Descrição muito curta';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                        height: 44,
                        child: channelReceived != null
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Get.back();
                                    await channelController.updateChannel();
                                    Get.snackbar('Atualizado',
                                        'Canal ${channelController.channel.name} atualizado com sucesso!',
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.black,
                                        backgroundGradient: linearGreen,
                                        duration: const Duration(seconds: 3),
                                        margin:
                                            const EdgeInsets.only(bottom: 8));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                child: const Text(
                                  'Atualizar',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Get.back();
                                    await channelController.addChannel();
                                    Get.snackbar('Cadastrado',
                                        'Canal ${channelController.channel.name} cadastrado com sucesso!',
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.black,
                                        backgroundGradient: linearGreen,
                                        duration: const Duration(seconds: 3),
                                        margin:
                                            const EdgeInsets.only(bottom: 8));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              )),
                  ],
                ),
              )),
        ),
      )),
    );
  }

  void verificaReceived() {
    if (channelReceived != null) {
      channelController.channel = channelReceived!;
    } else {
      channelController.channel = ChannelModel();
    }
  }
}
