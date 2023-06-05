import 'package:dartt_maat_v2/pages/auth/view/signin_screen.dart';
import 'package:dartt_maat_v2/pages/auth/view/signout_screen.dart';
import 'package:dartt_maat_v2/pages/channel/binding/channel_binding.dart';
import 'package:dartt_maat_v2/pages/channel/view/channel_screen.dart';
import 'package:dartt_maat_v2/pages/dashboard/view/dashboard_screen.dart';
import 'package:dartt_maat_v2/pages/ocurrency/binding/ocurrency_binding.dart';
import 'package:dartt_maat_v2/pages/ocurrency/view/ocurrency_print.dart';
import 'package:dartt_maat_v2/pages/ocurrency/view/ocurrency_screen.dart';
import 'package:dartt_maat_v2/pages/status/binding/status_binding.dart';
import 'package:dartt_maat_v2/pages/status/view/status_screen.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/binding/typeocurrency_binding.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/view/typeocurrency_screen.dart';
import 'package:dartt_maat_v2/pages/user/binding/user_binding.dart';
import 'package:dartt_maat_v2/pages/user/view/user_screen.dart';
import 'package:get/route_manager.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PageRoutes.home, page: () => const DashBoardScreen(), bindings: [
      OcurrencyBinding(),
      StatusBinding(),
      TypeOcurrencyBinding(),
      ChannelBinding(),
    ]),
    GetPage(name: PageRoutes.signin, page: () => SignInScreen(), binding:       UserBinding(),),
    GetPage(name: PageRoutes.signup, page: () => SignUpScreen()),
    GetPage(name: PageRoutes.channel, page: () => const ChannelScreen()),
    GetPage(name: PageRoutes.status, page: () => const StatusScreen()),
    GetPage(name: PageRoutes.users, page: () => const UserScreen()),
    GetPage(name: PageRoutes.typeocurrency, page: () => const TypeOcurrencyScreen()),
    GetPage(name: PageRoutes.ocurrency, page: () => const OcurrencyScreen()),
    GetPage(name: PageRoutes.ocurrencyDetail, page: () => ScreenDetail()),
  ];
}

abstract class PageRoutes {
  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String channel = '/channel';
  static const String status = '/status';
  static const String users = '/users';
  static const String typeocurrency = '/typeocurrency';
  static const String ocurrency = '/ocurrency';
  static const String ocurrencyDetail = '/ocurrency-detail';
}
