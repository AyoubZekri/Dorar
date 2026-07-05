import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Bindings/Initialbindings.dart';
import 'controller/ThemeController.dart';
import 'core/constant/Themdata.dart';
import 'core/services/Services.dart';
import 'routes.dart';
import 'core/constant/routes.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    
    return Obx(() => GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      title: 'الدرر اللوامع',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: themeController.themeMode.value,
      initialRoute: Approutes.splashScreen,
      initialBinding: Initialbindings(),
      getPages: routes,
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
    ));
  }
}

