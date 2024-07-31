import 'package:dio/dio.dart';

class BaseApi{
  final dio = Dio(BaseOptions(baseUrl: "yourApiBaseUrl"));
}