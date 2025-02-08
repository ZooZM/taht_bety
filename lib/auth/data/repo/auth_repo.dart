import 'package:dartz/dartz.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> fetchUser(String token);
  Future<Either<Failure, UserModel>> login(String email, String password);
  Future<Either<Failure, String>> register(String email, String password);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> resetPassword(String password, String token);
  Future<Either<Failure, String>> verifyEmail(String email, int code);
}
