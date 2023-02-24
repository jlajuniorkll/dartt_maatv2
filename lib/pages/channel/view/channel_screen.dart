import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/common/search_dialog.dart';
import 'package:dartt_maat_v2/pages/channel/components/channel_form.dart';
import 'package:dartt_maat_v2/pages/channel/components/channel_listtile.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GetBuilder<ChannelController>(builder: (controller) {
          return controller.searchChannel.isEmpty
              ? const Text('Canais de atendimento')
              : LayoutBuilder(builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchChannel));
                      if (search != null) {
                        controller.searchChannel = search;
                      }
                    },
                    child: SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          controller.searchChannel,
                          textAlign: TextAlign.center,
                        )),
                  );
                });
        }),
                actions: [
          GetBuilder<ChannelController>(
            builder: (controller) {
              if (controller.searchChannel.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchChannel));
                      if (search != null) {
                        controller.searchChannel = search;
                      }
                    },
                    icon: const Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () {
                      controller.searchChannel = '';
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
      body: GetBuilder<ChannelController>(
        builder: (controller) {
          final filteredChannel = controller.filteredChannel;
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredChannel.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                    child: GestureDetector(
                  child: ChannelListTile(
                    channelReceived: filteredChannel[index],
                  ),
                ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.dialog(ChannelForm());
        },
        label: const Text("Adicionar"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
