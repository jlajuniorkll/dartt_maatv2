import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_form.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcurrencyListTile extends StatelessWidget {
  const OcurrencyListTile({Key? key, required this.ocurrencyReceived})
      : super(key: key);

  final OcurrencyModel ocurrencyReceived;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${ocurrencyReceived.protocolo!} - ${ocurrencyReceived.cliente!.nome!}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ocurrencyReceived.cliente!.cpf!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Column(
                          children: List.generate(
                            ocurrencyReceived.fornecedores!.length,
                            (index) => Text(
                              ocurrencyReceived.fornecedores![index].fantasia!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Abertura: ${ocurrencyReceived.channel!.name} - ${ocurrencyReceived.user!.name}",
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Última modificação: ${ocurrencyReceived.dataAt}",
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder:
                            (_) => /*OcurrencyFormComment(
                              ocurrency: widget.ocurrency,
                              comentarios: widget.ocurrency.comentarios)),*/
                                const OcurrencyFormScreen()),
                    child: Container(
                      padding: const EdgeInsets.only(left: 4, right: 6),
                      child: Icon(Icons.comment,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (_) {
                          // OcurrencyFormScreen(ocurrency: widget.ocurrency)),
                          final controller = Get.find<OcurrencyController>();
                          controller.setOcurrency(ocurrencyReceived);
                          return const OcurrencyFormScreen();
                        }),
                    child: Container(
                      padding: const EdgeInsets.only(left: 4, right: 6),
                      child: Icon(Icons.edit,
                          color: Theme.of(context).primaryColor),
                    ),
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
