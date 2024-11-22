import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/core/utils/service_locator.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

void main() {
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
          )..fetchProviderList(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
