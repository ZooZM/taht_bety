import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_storge.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/order/data/repo/order_repo_implementation.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_impl.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recenet_search_model_storge.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recent_search_model.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CurUserAdapter());
  Hive.registerAdapter(RecentSearchModelAdapter());
  Hive.registerAdapter(BasketModelAdapter());
  Hive.registerAdapter(FavProviderModelAdapter());
  try {
    await BasketStorage.init();
    await UserStorage.init();
    await RecentSearchModelStorage.init();
    await FavProviderStorage.init();
  } catch (e) {
    await BasketStorage.deleteBox();
    await UserStorage.deletFromBox();
    await RecentSearchModelStorage.deletFromBox();
    await FavProviderStorage.deleteBox();
    await BasketStorage.init();
    await UserStorage.init();
    await RecentSearchModelStorage.init();
    await FavProviderStorage.init();
  }
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
