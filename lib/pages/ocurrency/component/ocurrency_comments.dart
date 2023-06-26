import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentOcurrency extends StatelessWidget {
  const CommentOcurrency({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .5;
    final GlobalKey<FormState> formKeyComments = GlobalKey<FormState>();
    final userController = Get.find<UserController>();
    final FocusNode focusNode = FocusNode();
    return Center(
      child: SizedBox(
        width: isMobile < 800 ? widhtMobile : widhtWeb,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Form(
              key: formKeyComments,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsetsDirectional.all(16),
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.close),
                            )),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: const Text(
                            "Comentários",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<OcurrencyController>(builder: (controller) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<UserModel>(
                          focusNode: focusNode,
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            isDense: true,
                            labelText: 'Responsável',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          value: controller.ocurrency.responsavel,
                          onChanged: (UserModel? newValue) {
                            controller.setUserOcurrency(newValue!);
                            focusNode.nextFocus();
                          },
                          onSaved: (newValue) {
                            controller.setUserOcurrency(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Escolha uma opção';
                            }
                            return null;
                          },
                          items: userController.selectResponsavel
                              .map<DropdownMenuItem<UserModel>>((UserModel e) {
                            return DropdownMenuItem<UserModel>(
                              value: e,
                              child: Text(e.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextField(
                    label: 'Digite seu comentário...',
                    iniValue: '',
                    onSaved: null,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
