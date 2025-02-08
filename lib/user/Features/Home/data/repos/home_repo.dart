import 'package:location/location.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProviderModel>>> fetchProviderList();
  Future<Either<Failure, LocationData>> fetchLocation();
}
