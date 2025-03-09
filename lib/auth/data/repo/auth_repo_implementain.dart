import 'package:dartz/dartz.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/auth/data/repo/auth_repo.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/data.dart';

class AuthRepoImplementain implements AuthRepo {
  final ApiService apiService;

  AuthRepoImplementain(this.apiService);
  @override
  Future<Either<Failure, UserModel>> fetchUser(String token) async {
    try {
      const endPoint = "user/me";
      final response = await apiService.get(endPoint: endPoint, token: token);
      final user = UserModel.fromJson(response['data']['data']);
      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      const endPoint = "auth/login";
      var response = await apiService.post(
        endPoint: endPoint,
        data: {'email': email, 'password': password},
      );
      if (response['data']['error_code'] == "A4000") {
        return left(VerificationFailure(email));
      }
      if (response['data'] == null || response['data']['user'] == null) {
        return left(Serverfailure(response['message']));
      }

      final userData = response['data']['user'];
      UserModel user = Data.user;
      user = UserModel.fromJson(userData);

      UserStorage.saveUserData(
          token: user.token!, userId: user.id!, lat: '0', long: '0');
      return right(user);
    } catch (e) {
      if (e is DioException) {
        if (e.response!.data['error_code'] == "A4000") {
          return left(VerificationFailure(email));
        }
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> resetPassword(String password, String token) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> verifyEmail(String email, int code) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
