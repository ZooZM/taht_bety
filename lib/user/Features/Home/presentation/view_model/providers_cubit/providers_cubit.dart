import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/data.dart';
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

  Future<void> filterProvidersByCategory(String category) async {
    emit(ProvidersLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<ProviderModel> providers = Data.providers;
    print(providers.length);
    List<ProviderModel> result = [];
    if (category == "A-All") {
      result = providers;
    } else {
      for (var e in providers) {
        if (e.providerType!.contains(category)) {
          result.add(e);
        }
      }
    }
    if (result.isNotEmpty) {
      emit(ProvidersSuccess(result));
    } else {
      emit(ProvidersFailure(
          'No providers found for category: ${category.split('-')[1]}'));
    }
  }
}
