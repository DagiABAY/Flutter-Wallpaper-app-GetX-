import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/modules/homepage/home_controller.dart';
import 'package:wallpaper_app/modules/wallpaper_page/wallpaper_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _pagecontroller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      _pagecontroller = controller;
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: _appBar(),
          drawer: _drawer(),
          body: Container(
            height: MediaQuery.of(context).size.height * 0.83,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Obx(
              () {
                return _wallpapersView();
              },
            ),
          ));
    });
  }

  AppBar _appBar() {
    return AppBar(
      foregroundColor: Colors.white,
      title: const Text(
        "Wallpaper",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      backgroundColor: const Color.fromARGB(231, 101, 3, 238),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
          color: Colors.white,
        ),
        PopupMenuButton<String>(
          onSelected: (value) {},
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'item1',
              child: ListTile(
                title: const Text(""),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Drawer _drawer() {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _wallpapersView() {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final before = notification.metrics.extentBefore;
          final max = notification.metrics.maxScrollExtent;
          if (before == max) {
            _pagecontroller.getWallpapers();
            return true;
          }
          return false;
        } else {
          return false;
        }
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 3.5,
        ),
        itemCount: _pagecontroller.wallpapers.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: 0,
              ),
              child: GestureDetector(
                  onTap: () {},
                  child: MyListTile(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.85,
                    wallpaper: _pagecontroller.wallpapers[index],
                  )));
        },
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final double height;
  final double width;
  final Wallpaper wallpaper;
  const MyListTile({
    super.key,
    required this.height,
    required this.width,
    required this.wallpaper,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("${wallpaper.posterPath}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Get.to(() => WallpaperPage(), arguments: wallpaper);
              },
              backgroundColor: const Color.fromARGB(241, 97, 3, 230),
              child: const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
