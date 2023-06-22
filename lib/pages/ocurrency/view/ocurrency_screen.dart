import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/models/status_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_form.dart';
import 'package:dartt_maat_v2/pages/ocurrency/component/ocurrency_listile.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/status/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcurrencyScreen extends StatefulWidget {
  const OcurrencyScreen({super.key});

  @override
  State<OcurrencyScreen> createState() => _OcurrencyScreenState();
}

class _OcurrencyScreenState extends State<OcurrencyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> _tabs = [];
  List<StatusModel> statusList = [];
  final controllerStatus = Get.find<StatusController>();
  final controllerOcurrency = Get.find<OcurrencyController>();

  @override
  void initState() {
    super.initState();
    statusList = controllerStatus.filteredStatusActive;
    _tabs = List<Tab>.generate(statusList.length, (index) {
      return Tab(
        text: statusList[index].name!,
      );
    });
    _tabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ocorrências'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
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
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((Tab tab) {
          // final String label = tab.text!.toUpperCase().trim();
          return GetBuilder<OcurrencyController>(
            builder: (controller) {
              final filteredOcurrency = controller.allOcurrency;
              return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredOcurrency.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        child: GestureDetector(
                      child: OcurrencyListTile(
                        ocurrencyReceived: filteredOcurrency[index],
                      ),
                    ));
                  });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controllerOcurrency.ocurrency.id != null) {
            controllerOcurrency.clearAll();
          }
          Get.dialog(const OcurrencyFormScreen());
        },
        label: const Text("Adicionar"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
