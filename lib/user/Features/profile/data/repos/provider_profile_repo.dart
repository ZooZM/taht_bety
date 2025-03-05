import 'package:taht_bety/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';

abstract class ProviderProfileRepo {
  Future<Either<Failure, ProviderModel>> fetchProvider(String id);
}
