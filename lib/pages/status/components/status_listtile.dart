import 'package:dartt_maat_v2/common/alerts/alert_widget.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/pages/status/components/status_form.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusListTile extends StatelessWidget {
  const StatusListTile({required Key key, required this.statusReceived})
      : super(key: key);

  final StatusModel statusReceived;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatusController>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 4, right: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusReceived.name!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            statusReceived.description!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                          padding: const EdgeInsets.only(left: 8, right: 6),
                          child: Text(
                            'Ordem: ${statusReceived.priority!.toString()}',
                            style: const TextStyle(fontSize: 10.0),
                          ),
                        ),*/
                    GestureDetector(
                      onTap: () {
                        Get.dialog(StatusForm(
                          statusReceived: statusReceived,
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 4, right: 6),
                        child: Icon(Icons.edit,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Switch(
                        value: statusReceived.isActive,
                        activeColor: Colors.blue,
                        onChanged: (bool value) async {
                            final confirm = await Get.dialog<bool>(AlertFetch(
                            title: 'Tem certeza?',
                            body:
                                'Deseja inativar o seguinte status: ${statusReceived.name}? Lembrando que a aba na tela de ocorrência desaparecerá e só poderá verificar as ocorrências abertas ao filtrar tudo! Ou reativando este status...'));
                        if (confirm == true) {
                         controller.setIsActive(statusReceived);
                          Get.snackbar('Inativo:',
                              'Status ${statusReceived.name} foi inativado com sucesso!',
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.black,
                              backgroundGradient: linearGreen,
                              duration: const Duration(seconds: 4),
                              margin: const EdgeInsets.only(bottom: 8));
                        }                            
                        }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
