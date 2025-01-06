import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';

part 'fetch_location_state.dart';

class FetchLocationCubit extends Cubit<FetchLocationState> {
  FetchLocationCubit(this.homeRepo) : super(FetchLocationInitial());
  final HomeRepo homeRepo;
  Future<void> fetchLocation() async {
    emit(FetchLocationLoading());
    var result = await homeRepo.fetchLocation();
    result.fold((failure) {
      emit(FetchLocationFailure(failure.failurMsg));
    }, (data) {
      emit(FetchLocationSuccess(data));
    });
  }
}
