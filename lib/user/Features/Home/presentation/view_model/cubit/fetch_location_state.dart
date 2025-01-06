part of 'fetch_location_cubit.dart';

@immutable
sealed class FetchLocationState {}

final class FetchLocationInitial extends FetchLocationState {}

final class FetchLocationLoading extends FetchLocationState {}

final class FetchLocationFailure extends FetchLocationState {
  final String failureMssg;

  FetchLocationFailure(this.failureMssg);
}

final class FetchLocationSuccess extends FetchLocationState {
  final LocationData locationData;

  FetchLocationSuccess(this.locationData);

  get data => null;
}
