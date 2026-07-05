import 'package:get/get.dart';

import '../core/services/Services.dart';



class Initialbindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Myservices());
  }
}
