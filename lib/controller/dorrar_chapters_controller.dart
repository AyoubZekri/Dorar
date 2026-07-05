import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/Services.dart';

class DorrarChaptersController extends GetxController {
  var chapters = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadChapters();
  }

  void loadChapters() {
    try {
      BookDataService bookDataService = Get.find<BookDataService>();
      if (bookDataService.chapters.isNotEmpty) {
        chapters.value = bookDataService.chapters;
      } else {
        _loadChaptersFallback();
      }
    } catch (e) {
      // Fallback in case Get.find fails (e.g., during hot reload)
      _loadChaptersFallback();
    }
  }

  void _loadChaptersFallback() async {
    try {
      String jsonString =
          await rootBundle.loadString('lib/data/Static/book_detailed.json');
      var jsonData = json.decode(jsonString);
      chapters.value = jsonData['chapters'] ?? [];
    } catch (e) {
      print("Error loading chapters fallback: $e");
    }
  }

  void goToChapter(int index) {
    Get.toNamed(Approutes.dorrarVerses, arguments: chapters[index]);
  }
}
