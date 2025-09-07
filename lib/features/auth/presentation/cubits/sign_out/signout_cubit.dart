import 'package:bloc/bloc.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  SignoutCubit(this._authRepo) : super(SignoutInitial());
  final AuthRepo _authRepo;

  Future<void> signOut() async {
    emit(SignoutLoading());
    try {
      await _authRepo.SignOut();
      emit(SignoutSuccess());
    } catch (e) {
      emit(SignoutFailed(e.toString()));
    }
  }
}
