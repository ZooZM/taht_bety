import 'package:dio/dio.dart';

class ApiService {
  //http://10.0.2.2
  //http://192.168.1.5
  final String _baseUrl =
      'https://ta7t-bety-anb3dfg0e2dra6hp.germanywestcentral-01.azurewebsites.net/api/v1/';

  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$_baseUrl$endPoint');

    return response.data;
  }
}
