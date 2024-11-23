import 'package:dio/dio.dart';

class ApiService {
  //http://10.0.2.2
  final String _baseUrl = 'http://192.168.1.11:8000/api/';

  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$_baseUrl$endPoint');

    return response.data;
  }
}
