import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthFailure(failureMssg: "Email and password cannot be empty"));
      return;
    }

    emit(AuthLoading());

    try {
      final result = await authRepo.login(email, password);
      result.fold(
        (failure) => emit(AuthFailure(failureMssg: failure.failurMsg)),
        (user) => emit(AuthSuccess(user: user)),
      );
    } catch (e) {
      emit(AuthFailure(failureMssg: "An unexpected error occurred: $e"));
    }
  }
}
