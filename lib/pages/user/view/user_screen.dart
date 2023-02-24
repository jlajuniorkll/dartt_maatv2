import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/common/search_dialog.dart';
import 'package:dartt_maat_v2/pages/user/components/user_form.dart';
import 'package:dartt_maat_v2/pages/user/components/user_listtile.dart';
import 'package:dartt_maat_v2/pages/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        title: GetBuilder<UserController>(
          builder: (controller) {
            if (controller.searchUser.isEmpty) {
              return const Text('Cadastro de usuários');
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                            initialText: controller.searchUser));
                    if (search != null) {
                      controller.searchUser = search;
                    }
                  },
                  child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        controller.searchUser,
                        textAlign: TextAlign.center,
                      )),
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: [
          GetBuilder<UserController>(
            builder: (controller) {
              if (controller.searchUser.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                              initialText: controller.searchUser));
                      if (search != null) {
                        controller.searchUser = search;
                      }
                    },
                    icon: const Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () {
                      controller.searchUser = '';
                    },
                    icon: const Icon(Icons.close));
              }
            },
          )
        ],
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.filteredUser.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  child: UserListTile(userReceived: controller.filteredUser[index]),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => UserForm());
        },
        label: const Text("Adicionar"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
