import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/service_locator.dart';
import 'package:taht_bety/user/Features/Home/data/models/user_info/address_model.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/cubit/fetch_location_cubit.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

void main() async {
  setup();
  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox<AddressModel>(kAddressBox);
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
          )..fetchProviderList(),
        ),
        BlocProvider(
          create: (context) => FetchLocationCubit(
            getIt<HomeRepoImpl>()..fetchLocation(),
          ),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
