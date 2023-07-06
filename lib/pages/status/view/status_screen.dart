import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/common/search_dialog.dart';
import 'package:dartt_maat_v2/pages/status/components/status_form.dart';
import 'package:dartt_maat_v2/pages/status/components/status_listtile.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GetBuilder<StatusController>(builder: (controller) {
          return controller.searchStatus.isEmpty
              ? const Text('Situação da Reclamação')
              : LayoutBuilder(builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchStatus));
                      if (search != null) {
                        controller.searchStatus = search;
                      }
                    },
                    child: SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          controller.searchStatus,
                          textAlign: TextAlign.center,
                        )),
                  );
                });
        }),
        actions: [
          GetBuilder<StatusController>(
            builder: (controller) {
              if (controller.searchStatus.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchStatus));
                      if (search != null) {
                        controller.searchStatus = search;
                      }
                    },
                    icon: const Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () {
                      controller.searchStatus = '';
                    },
                    icon: const Icon(Icons.close));
              }
            },
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: GetBuilder<StatusController>(
        builder: (controller) {
          return Theme(
            data: ThemeData(canvasColor: Colors.transparent),
            child: ReorderableListView.builder(
              key: UniqueKey(),
              footer: controller.reorder == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.confirmReorder();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00CCFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text('Salvar ordem'))),
                    )
                  : null,
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.filteredStatus.length,
              itemBuilder: (_, index) {
                return StatusListTile(
                  key: ValueKey(controller.filteredStatus[index].id),
                  statusReceived: controller.filteredStatus[index],
                );
              },
              onReorder: ((oldIndex, newIndex) {
                controller.reorderStatus(oldIndex, newIndex);
              }),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.dialog(StatusForm());
        },
        label: const Text("Adicionar"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
