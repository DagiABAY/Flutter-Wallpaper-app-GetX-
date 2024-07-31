import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/modules/homepage/home_binding.dart';
import 'package:wallpaper_app/modules/splash_page.dart';
import 'package:wallpaper_app/routes/app_page.dart';

import 'modules/homepage/home_page.dart';

void main() {
  runApp(
    SplashPage(
      onInitalizationComplete: () => runApp(
        const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialBinding: HomeBindings(),
      getPages: AppPages.pages,
    );
  }
}
