import 'package:dartt_maat_v2/common/alerts/alert_widget.dart';
import 'package:dartt_maat_v2/config/const.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/user/components/user_form.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({Key? key, required this.userReceived}) : super(key: key);

  final UserModel userReceived;

  @override
  Widget build(BuildContext context) {
      final controller = Get.find<UserController>();
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userReceived.name!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userReceived.email!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              userReceived.cpf!,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              userReceived.typeUser!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(UserForm(
                            userReceived: userReceived,
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
                                  'Deseja deletar o seguinte usuário: ${userReceived.name}?'));
                          if (confirm == true) {
                            await controller.deleteUser(userReceived.id!);
                            Get.snackbar('Exclusão:',
                                'Usuário ${userReceived.name} deletado com sucesso!',
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
                  )),
            ],
          ),
        ));
  }
}
