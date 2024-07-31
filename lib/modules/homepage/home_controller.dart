import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/apis/home_api.dart';
import 'package:wallpaper_app/models/wallpaper.dart';

class HomeController extends GetxController {
  TextEditingController name = TextEditingController();
  RxList<Wallpaper> wallpapers = <Wallpaper>[].obs;

  final homeApi = HomeApi();
  @override
  void onInit() {
    getWallpapers();
    super.onInit();
  }

  getWallpapers() async {
   var res = await homeApi.getWallpaper();
    if (res != null) {
      wallpapers.clear();
      res.forEach((item) {
        Wallpaper wallpaper = Wallpaper.fromJson(item);
        wallpapers.add(wallpaper);
      });
    }
  }
}
