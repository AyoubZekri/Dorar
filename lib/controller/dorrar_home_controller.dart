import 'package:get/get.dart';
import '../core/constant/routes.dart';
import 'ThemeController.dart';

class DorrarHomeController extends GetxController {
  void goToOverview() {
    Get.toNamed(Approutes.dorrarOverview);
  }

  void goToChapters() {
    Get.toNamed(Approutes.dorrarChapters);
  }

  void goToSavedVerses() {
    Get.toNamed(Approutes.dorrarSavedVerses);
  }

  void toggleDarkMode() {
    ThemeController themeController = Get.find();
    themeController.toggleTheme(!themeController.isDarkMode);
  }
}
