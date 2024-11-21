import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';

part 'providers_state.dart';

class ProvidersCubit extends Cubit<ProvidersState> {
  ProvidersCubit(this.homeRepo) : super(ProvidersInitial());
  final HomeRepo homeRepo;
  Future<void> fetchProviderList() async {
    emit(ProvidersLoading());
    var result = await homeRepo.fetchProviderList();
    result.fold((failure) {
      emit(ProvidersFailure(failure.failurMsg));
    }, (data) {
      emit(ProvidersSuccess(data));
    });
  }
}
