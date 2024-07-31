import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class WallpaperPage extends StatefulWidget {
  final Wallpaper wallpaper = Get.arguments;
  WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${widget.wallpaper.posterPath}"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.wallpaper.name}",
                    style: const TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Varela",
                        fontSize: 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Set Wallpaper'),
                                content: const Text(
                                    'Do you want to set this image as your wallpaper?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Set Wallpaper'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      // await _setWallpaper(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        backgroundColor:
                            const Color.fromARGB(239, 238, 141, 214),
                        child: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 30),
                      FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Download'),
                                content: const Text(
                                    'Do you want to download this image?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Download'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Future.microtask(() {
                                        _download(widget.wallpaper);
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        backgroundColor:
                            const Color.fromARGB(239, 238, 141, 214),
                        child: const Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _download(Wallpaper wallpaper) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      Dio dio = Dio();
      try {
        final response = await dio.get<Uint8List>(
          "${wallpaper.posterPath}",
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == 200) {
          final deviceInfo = DeviceInfoPlugin();
          final androidInfo = await deviceInfo.androidInfo;
          final int sdkInt = androidInfo.version.sdkInt;

          Directory directory;
          if (sdkInt < 29) {
            directory = Directory('/storage/emulated/0/Download');
          } else {
            directory = await getApplicationDocumentsDirectory();
          }

          final uniqueFilename = 'wallpaper${const Uuid().v4()}.jpg';
          final filePath = '${directory.path}/$uniqueFilename';
          final file = File(filePath);

          await file.writeAsBytes(response.data as Uint8List);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image saved to $filePath')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download image')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }
}
