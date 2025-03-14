import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/repo/auth_repo_implementain.dart';
import 'package:taht_bety/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/service_locator.dart';
import 'package:taht_bety/user/Features/order/presentation/cubit/order_cubit.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_impl.dart';
import 'package:taht_bety/user/Features/profile/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recent_search_model.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/cubit/fetch_location_cubit.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Hive.initFlutter();

  Hive.registerAdapter(CurUserAdapter());
  Hive.registerAdapter(RecentSearchModelAdapter());
  Hive.registerAdapter(BasketModelAdapter());
  await Hive.openBox<CurUser>(kCurUserBox);
  await Hive.openBox<RecentSearchModel>(kRecentSearchBox);
  try {
    await Hive.deleteBoxFromDisk(kBasketBox);
    await Hive.openBox<BasketModel>(kBasketBox);
    await BasketStorage.init();
  } catch (e) {
    print('Error opening basket box: $e');
  }
  print('main');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProvidersCubit(
            getIt<HomeRepoImpl>(),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            getIt<AuthRepoImplementain>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchLocationCubit(
            getIt<HomeRepoImpl>()..fetchLocation(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
