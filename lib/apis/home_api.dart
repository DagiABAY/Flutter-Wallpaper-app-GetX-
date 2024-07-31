import 'package:dio/dio.dart';
import 'package:wallpaper_app/apis/base_api.dart';

class HomeApi extends BaseApi {
  getWallpaper() async {
    try {
      var res = await dio
          .get("yourEndpoint");
      if (res.statusCode == 200) {
        return res.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}
