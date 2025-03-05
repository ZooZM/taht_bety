import 'package:location/location.dart';
import 'package:taht_bety/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProviderListModel>>> fetchProviderList();
  Future<Either<Failure, LocationData>> fetchLocation();
}
