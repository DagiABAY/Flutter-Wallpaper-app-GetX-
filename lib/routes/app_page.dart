import 'package:get/get.dart';
import 'package:wallpaper_app/modules/wallpaper_page/wallpaper_binding.dart';
import 'package:wallpaper_app/modules/wallpaper_page/wallpaper_page.dart';
import 'package:wallpaper_app/routes/app_route.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.WallpaperPage,
      page: () => WallpaperPage(),
      binding: WallpaperBindings(),
    )
  ];
}
