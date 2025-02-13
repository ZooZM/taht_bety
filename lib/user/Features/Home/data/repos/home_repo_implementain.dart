import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/app_fun.dart';
import 'package:taht_bety/core/utils/location_service.dart';
import 'package:taht_bety/data.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProviderModel>>> fetchProviderList() async {
    try {
      CurUser user = UserStorage.getUserData();
      var providerResponse = await apiService.get(
          endPoint: 'providers/${user.lat}/${user.long}/100/all');

      List<ProviderModel> _providers = [];

      final providerData =
          providerResponse['data']['providers'] as List<dynamic>?;

      if (providerData != null) {
        for (var item in providerData) {
          ProviderModel provider = ProviderModel.fromJson(item);

          if (provider.locations != null && provider.locations!.isNotEmpty) {
            var providerCoordinates = provider.locations![0].coordinates;
            double? temp = providerCoordinates?.coordinates![0];
            providerCoordinates?.coordinates![0] =
                providerCoordinates.coordinates![1];
            providerCoordinates?.coordinates![1] = temp!;
            if (providerCoordinates != null &&
                providerCoordinates.coordinates!.length >= 2) {
              double providerLat = providerCoordinates.coordinates![1];
              double providerLon = providerCoordinates.coordinates![0];
              double userLat = double.parse(user.lat);
              double userLon = double.parse(user.long);

              double distance = AppFun.calculateDistance(
                  userLat, userLon, providerLat, providerLon);
              provider = provider.copyWith(distance: distance);
            }
          }

          _providers.sort((a, b) => a.distance!.compareTo(b.distance!));
          _providers.add(provider);
        }
      }

      Data.providers = _providers;
      return _providers.isEmpty
          ? left(Serverfailure("No providers found"))
          : right(_providers);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationData>> fetchLocation() async {
    try {
      LocationService locationService = LocationService();
      LocationData location = await locationService.getLocation();

      return right(location);
    } catch (e) {
      return left(Serverfailure(e.toString()));
    }
  }
}
