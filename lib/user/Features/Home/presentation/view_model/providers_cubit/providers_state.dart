part of 'providers_cubit.dart';

@immutable
sealed class ProvidersState {}

final class ProvidersInitial extends ProvidersState {}

final class ProvidersLoading extends ProvidersState {}

final class ProvidersFailure extends ProvidersState {
  final String failureMssg;

  ProvidersFailure(this.failureMssg);
}

final class ProvidersSuccess extends ProvidersState {
  final List<ProviderListModel> providers;

  ProvidersSuccess(this.providers);
}
