import 'package:dartt_maat_v2/common/alerts/alert_widget.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/channel_model.dart';
import 'package:dartt_maat_v2/pages/channel/components/channel_form.dart';
import 'package:dartt_maat_v2/pages/channel/controller/channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelListTile extends StatelessWidget {
  const ChannelListTile({Key? key, required this.channelReceived})
      : super(key: key);

  final ChannelModel channelReceived;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChannelController>();
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
                          channelReceived.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          channelReceived.description!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(ChannelForm(
                        channelReceived: channelReceived,
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
                              'Deseja deletar o seguinte canal: ${channelReceived.name}?'));
                      if (confirm == true) {
                        await controller.deleteChannel(channelReceived.id!);
                        Get.snackbar('Exclusão:',
                            'Canal ${channelReceived.name} deletado com sucesso!',
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
