import 'package:dartt_maat_v2/common/drawer/custom_drawer.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/channel_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/previsao_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/status_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/tableuser_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/tempo_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/total_dashboard.dart';
import 'package:dartt_maat_v2/pages/dashboard/component/trend_dashboard.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final isMobile = (sizeWidth <= 800.0);
    return Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Dashboard'),
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
        body: !isMobile
            ? ListView(
                shrinkWrap: true,
                children: const [
                   TotalDashBoard(),
                   TrendDashboard(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children:  [
                      Expanded(child: PrevisaoDashboard()),
                      Expanded(child: TempoDashboard()),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children:  [
                      Expanded(child: ChannelDashBoard()),
                      Expanded(child: StatusDashBoard()),
                    ],
                  ),
                   TableUserDashBoard(),
                ],
              )
            : ListView(
                shrinkWrap: true,
                children: const [
                  TotalDashBoard(),
                  TrendDashboard(),
                  PrevisaoDashboard(),
                  TempoDashboard(),
                  ChannelDashBoard(),
                  StatusDashBoard(),
                  TableUserDashBoard(),
                ],
              ));
  }
}
