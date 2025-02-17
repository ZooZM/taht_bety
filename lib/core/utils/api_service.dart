import 'package:dio/dio.dart';

class ApiService {
  //http://10.0.2.2
  //http://192.168.1.5  //mobile device
  // https://ta7t-bety-anb3dfg0e2dra6hp.germanywestcentral-01.azurewebsites.net/api/v1/
  final String _baseUrl = 'http://localhost:8000/api/v1/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }
}
