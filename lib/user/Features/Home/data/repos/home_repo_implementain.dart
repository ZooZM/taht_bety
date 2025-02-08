import 'package:dartz/dartz.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/location_service.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProviderModel>>> fetchProviderList() async {
    try {
      CurUser user = UserStorage.getUserData();

      var data = await apiService.get(
          endPoint: 'providers/${user.long}/${user.lat}/1000/F-Restaurants');
      List<ProviderModel> providers = [];
      for (var item in data['data']['data']) {
        providers.add(ProviderModel.fromJson(item));
      }
      return right(providers);
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
