import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/common/search_dialog.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/view/component/typeocurrency_form.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/view/component/typeocurrency_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeOcurrencyScreen extends StatefulWidget {
  const TypeOcurrencyScreen({Key? key}) : super(key: key);

  @override
  State<TypeOcurrencyScreen> createState() => _TypeOcurrencyScreenState();
}

class _TypeOcurrencyScreenState extends State<TypeOcurrencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GetBuilder<TypeOcurrencyController>(builder: (controller) {
          return controller.searchTypeOcurrency.isEmpty
              ? const Text('Tipos de reclamação')
              : LayoutBuilder(builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchTypeOcurrency));
                      if (search != null) {
                        controller.searchTypeOcurrency = search;
                      }
                    },
                    child: SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          controller.searchTypeOcurrency,
                          textAlign: TextAlign.center,
                        )),
                  );
                });
        }),
        actions: [
          GetBuilder<TypeOcurrencyController>(
            builder: (controller) {
              if (controller.searchTypeOcurrency.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchTypeOcurrency));
                      if (search != null) {
                        controller.searchTypeOcurrency = search;
                      }
                    },
                    icon: const Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () {
                      controller.searchTypeOcurrency = '';
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
      body: GetBuilder<TypeOcurrencyController>(
        builder: (controller) {
          final filteredTypeOcurrency = controller.filteredTypeOcurrency;
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredTypeOcurrency.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                    child: GestureDetector(
                  child: TypeOcurrencyListTile(
                    typeocurrencyReceived: filteredTypeOcurrency[index],
                  ),
                ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.dialog(TypeOcurrencyForm());
        },
        label: const Text("Adicionar"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
