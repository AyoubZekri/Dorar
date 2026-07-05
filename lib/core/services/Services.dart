import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Myservices extends GetxService {
  SharedPreferences? sharedPreferences;

  Future<Myservices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

class RefreshService extends GetxService {
  var refreshTrigger = false.obs;

  void fire() {
    refreshTrigger.value = !refreshTrigger.value;
  }
}

class BookDataService extends GetxService {
  List<dynamic> chapters = [];

  Future<BookDataService> init() async {
    try {
      String jsonString = await rootBundle.loadString('lib/data/Static/book_detailed.json');
      var jsonData = json.decode(jsonString);
      chapters = jsonData['chapters'] ?? [];
    } catch (e) {
      print("Error preloading book data: $e");
    }
    return this;
  }
}

initialServices() async {
  print("initialServices running");
  await Get.putAsync(() => Myservices().init());
  await Get.putAsync(() => BookDataService().init());
  print("initialServices done");
}
