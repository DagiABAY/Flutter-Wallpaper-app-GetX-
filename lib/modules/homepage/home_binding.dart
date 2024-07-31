import 'package:get/get.dart';
import 'package:wallpaper_app/modules/homepage/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
