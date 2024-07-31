import 'package:get/get.dart';
import 'package:wallpaper_app/modules/wallpaper_page/wallpaper_controller.dart';

class WallpaperBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WallpaperController());
  }
}
