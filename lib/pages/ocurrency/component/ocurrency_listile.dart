import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';
import 'package:dartt_maat_v2/pages/comments/controller/comments_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_badge.dart';
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
    return GestureDetector(
      onTap: () =>
          Get.toNamed(PageRoutes.ocurrencyDetail, arguments: ocurrencyReceived),
      child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BadgeCustom(
                  previsao: Get.find<OcurrencyController>()
                      .getPrevisao(ocurrencyReceived.dataRegistro!)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                ocurrencyReceived
                                    .fornecedores![index].fantasia!,
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
                      onTap: () async {
                        await Get.find<CommentsController>()
                            .getAllComentarios(ocurrency: ocurrencyReceived);
                        Get.toNamed(PageRoutes.comments,
                            arguments: ocurrencyReceived);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 4, right: 6),
                        child: Icon(Icons.comment,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.find<OcurrencyController>()
                            .setOcurrency(ocurrencyReceived);
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const OcurrencyFormScreen();
                            });
                      },
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
          )),
    );
  }
}
