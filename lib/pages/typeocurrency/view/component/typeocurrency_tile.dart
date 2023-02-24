import 'package:dartt_maat_v2/common/alerts/alert_widget.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/view/component/typeocurrency_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeOcurrencyListTile extends StatelessWidget {
  const TypeOcurrencyListTile({Key? key, required this.typeocurrencyReceived})
      : super(key: key);

  final TypeOcurrencyModel typeocurrencyReceived;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TypeOcurrencyController>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          typeocurrencyReceived.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          typeocurrencyReceived.description!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(TypeOcurrencyForm(
                        typeOcurrencyReceived: typeocurrencyReceived,
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 4, right: 6),
                      child: Icon(Icons.edit,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final confirm = await Get.dialog<bool>(AlertFetch(
                          title: 'Tem certeza?',
                          body:
                              'Deseja deletar o seguinte tipo de situação: ${typeocurrencyReceived.name}?'));
                      if (confirm == true) {
                        await controller
                            .deleteTypeOcurrency(typeocurrencyReceived.id!);
                        Get.snackbar('Exclusão:',
                            'Tipo de ocorrência ${typeocurrencyReceived.name} deletado com sucesso!',
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.black,
                            backgroundGradient: linearGreen,
                            duration: const Duration(seconds: 4),
                            margin: const EdgeInsets.only(bottom: 8));
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[600],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
