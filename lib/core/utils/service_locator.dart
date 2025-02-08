import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:taht_bety/auth/data/repo/auth_repo_implementain.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      ApiService(
        Dio(),
      ),
    ),
  );
  getIt.registerSingleton<AuthRepoImplementain>(
    AuthRepoImplementain(
      ApiService(
        Dio(),
      ),
    ),
  );
}
