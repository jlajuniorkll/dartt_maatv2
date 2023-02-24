import 'package:dartt_maat_v2/common/drawer/components/custom_drawerheader.dart';
import 'package:dartt_maat_v2/common/drawer/components/drawer_tile.dart';
import 'package:dartt_maat_v2/common/drawer/components/expand_tilte.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      elevation: 5,
      child: Stack(
        children: [
          ListView(children: const [
            CustomDrawerHeader(),
            DrawerTile(
              iconData: Icons.dashboard,
              title: 'Dashboard',
              route: PageRoutes.home,
            ),
            DrawerTile(
              iconData: Icons.list,
              title: 'Reclamações',
              route: PageRoutes.ocurrency,
            ),
            DrawerTile(
              iconData: Icons.menu_book,
              title: 'Documentos',
              route: PageRoutes.home,
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 0.0, right: 16.0),
              childrenPadding: EdgeInsets.only(left: 32.0),
              title:
                  ExpandTile(iconData: Icons.check_circle, title: 'Cadastros'),
              children: [
                DrawerTile(
                  iconData: Icons.fact_check,
                  title: 'Tipo de reclamação',
                  route: PageRoutes.typeocurrency,
                ),
                DrawerTile(
                  iconData: Icons.done,
                  title: 'Situação',
                  route: PageRoutes.status,
                ),
                DrawerTile(
                  iconData: Icons.call,
                  title: 'Canais',
                  route: PageRoutes.channel,
                ),
                DrawerTile(
                  iconData: Icons.account_circle,
                  title: 'Usuários',
                  route: PageRoutes.users,
                ),
              ],
            ),
            DrawerTile(
              iconData: Icons.settings,
              title: 'Configurações',
              route: PageRoutes.home,
            ),
          ]),
        ],
      ),
    );
  }
}
