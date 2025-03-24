import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/auth/data/repo/auth_repo_implementain.dart';
import 'package:taht_bety/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/service_locator.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/cubit/fetch_location_cubit.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

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
