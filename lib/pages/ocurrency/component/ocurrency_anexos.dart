import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormAnexos extends StatelessWidget {
  const FormAnexos({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: Get.find<OcurrencyController>().formKeyDescription,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Adicionar Anexos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.find<OcurrencyController>().selectCamera();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("Tirar foto")),
                  const SizedBox(
                    width: 32,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.find<OcurrencyController>().selectFile();
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Anexar arquivo")),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<OcurrencyController>(
                builder: (controller) =>
                    controller.infoUpload != ''
                        ? SizedBox(
                            width: 600,
                            child: LinearProgressIndicator(
                              value: (controller.progress/100),
                            ))
                        : const SizedBox(height: 6),
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<OcurrencyController>(
                builder: (controller) => controller.infoUpload != ''
                    ? Text(controller.infoUpload)
                    : const SizedBox(height: 6),
              ),
                            const SizedBox(
                height: 16,
              ),
              GetBuilder<OcurrencyController>(builder: (controller){
                return ListView.builder(
                  shrinkWrap: true,     
                  itemCount: controller.listAnexos.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.listAnexos[index].name!.split('z_z')[1]),
                          IconButton(onPressed: (){
                            controller.removeFileFirebase(controller.listAnexos[index]);
                          }, icon: const Icon(Icons.delete_forever, color: Colors.red,))
                        ],
                      ),
                    );
                  },                             
                 );
              })
            ])));
  }
}
