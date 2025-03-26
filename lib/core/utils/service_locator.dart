import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/order/data/repo/order_repo_implementation.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_impl.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      ApiService(
        Dio(),
      ),
    ),
  );

  getIt.registerSingleton<OrderRepoImpl>(
    OrderRepoImpl(
      ApiService(
        Dio(),
      ),
    ),
  );
  getIt.registerSingleton<ProviderProfileImpl>(
    ProviderProfileImpl(
      ApiService(
        Dio(),
      ),
    ),
  );
}
