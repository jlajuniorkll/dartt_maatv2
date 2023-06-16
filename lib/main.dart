import 'package:dartt_maat_v2/config/custom_colors.dart';
import 'package:dartt_maat_v2/firebase_options.dart';
import 'package:dartt_maat_v2/page_routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const List<LocalizationsDelegate<dynamic>> delegates =
      <LocalizationsDelegate<dynamic>>[
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Procon',
      theme: ThemeData(
        primarySwatch: CustomColors.customSwatchColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutes.signin,
      getPages: AppPages.pages,
    );
  }
}
