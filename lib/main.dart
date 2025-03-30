import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/service_locator.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/cubit/fetch_location_cubit.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_impl.dart';
import 'package:taht_bety/user/Features/profile/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recenet_search_model_storge.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recent_search_model.dart';
import 'package:taht_bety/user/Features/user_profile/presentation/cubit/profile_cubit.dart';


import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setup();
  await Hive.initFlutter();

  Hive.registerAdapter(CurUserAdapter());
  Hive.registerAdapter(RecentSearchModelAdapter());
  Hive.registerAdapter(BasketModelAdapter());
  await BasketStorage.init();
  await UserStorage.init();
  await RecentSearchModelStorage.init();
  print('Hive initialized');

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
        BlocProvider(
          create: (context) => FetchLocationCubit(
            getIt<HomeRepoImpl>()..fetchLocation(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchProviderCubit(
            getIt<ProviderProfileImpl>(),
          ),
        ),
     
               BlocProvider(
          create: (context) => ProfileCubit(),
       
        ), 
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
