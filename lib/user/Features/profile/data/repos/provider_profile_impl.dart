import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_repo.dart';

class ProviderProfileImpl implements ProviderProfileRepo {
  final ApiService apiService;

  ProviderProfileImpl(this.apiService);

  @override
  Future<Either<Failure, ProviderModel>> fetchProvider(
      String providerId) async {
    try {
      var providerResponse =
          await apiService.get(endPoint: 'providers/$providerId');

      ProviderModel? provider;

      final providerData = providerResponse['data'] as List<dynamic>?;

      if (providerData != null) {
        provider = ProviderModel.fromJson(providerData.first);
      }

      return provider == null
          ? left(Serverfailure("No provider found"))
          : right(provider);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }
}
