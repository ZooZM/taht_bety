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
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_storge.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProviderListModel>>> fetchProviderList() async {
    try {
      CurUser user = UserStorage.getUserData();
      FavProviderStorage.clearProviders();
      if (user.lat == '0.0' && user.long == '0.0') {
        return left(
            Serverfailure("Location not found, Please choose valid location"));
      }
      var providerResponse = await apiService.get(
          endPoint: 'providers/${user.lat}/${user.long}/100/all');

      List<ProviderListModel> providers = [];

      final providerData =
          providerResponse['data']['providers'] as List<dynamic>?;

      if (providerData != null) {
        bool checkfav(String id) {
          bool isCheck = false;
          if (user.favProviders.isNotEmpty) {
            for (var element in user.favProviders) {
              if (element == id) {
                isCheck = true;
              }
            }
            return isCheck;
          } else {
            return isCheck;
          }
        }

        for (var item in providerData) {
          ProviderListModel provider = ProviderListModel.fromJson(item);

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

          providers.sort((a, b) => a.distance!.compareTo(b.distance!));
          if (provider.userId != null) {
            if (checkfav(provider.userId!)) {
              FavProviderStorage.saveProvider(
                FavProviderModel(
                    id: provider.userId ?? "",
                    name: provider.name ?? "",
                    imageUrl: provider.photo ?? "",
                    distance: provider.distance ?? 0,
                    providerType: provider.providerType ?? "",
                    reviewsCount: provider.reviewsCount ?? 0,
                    avgRating: provider.avgRating ?? 0.0),
              );
            }
          }
          providers.add(provider);
        }
      }

      Data.providers = providers;
      return providers.isEmpty
          ? left(Serverfailure("No providers found"))
          : right(providers);
    } catch (e) {
      print("e: ${e.toString()}");
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          if (e.response!.data!["message"]
              .toLowerCase()
              .contains('no providers found.')) {
            return left(Serverfailure("No providers found, on this location."));
          }
        }

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
