import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/data/repos/provider_profile_repo.dart';

part 'fetch_provider_state.dart';

class FetchProviderCubit extends Cubit<FetchProviderState> {
  FetchProviderCubit(this.providerProfileRepo) : super(FetchProviderInitial());
  ProviderProfileRepo providerProfileRepo;
  Future<void> fetchProvider(String id) async {
    emit(FetchProviderLoading());
    var result = await providerProfileRepo.fetchProvider(id);
    result.fold((failure) {
      emit(FetchProviderFailure(failure.failurMsg));
    }, (data) {
      emit(FetchProviderSuccess(data));
    });
  }
}
