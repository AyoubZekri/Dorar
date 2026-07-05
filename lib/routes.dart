
import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'view/screen/dorrar_home_page.dart';
import 'view/screen/dorrar_overview_page.dart';
import 'view/screen/dorrar_chapters_page.dart';
import 'view/screen/dorrar_verses_page.dart';
import 'view/screen/dorrar_saved_verses_page.dart';
import 'view/screen/dorrar_splash_page.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: Approutes.dorrarHome, page: () => const DorrarHomePage()),
  GetPage(name: Approutes.dorrarOverview, page: () => const DorrarOverviewPage()),
  GetPage(name: Approutes.dorrarChapters, page: () => const DorrarChaptersPage()),
  GetPage(name: Approutes.dorrarVerses, page: () => const DorrarVersesPage()),
  GetPage(name: Approutes.dorrarSavedVerses, page: () => const DorrarSavedVersesPage()),
  GetPage(name: Approutes.splashScreen, page: () => const DorrarSplashPage()),
];
