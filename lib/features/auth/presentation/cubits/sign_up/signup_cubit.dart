import 'package:bloc/bloc.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    emit(SignupLoading());

    var result = await authRepo.CreateUserWithEmailAndPassword(
      email,
      password,
      name,
    );

    result.fold(
      (Failure) => emit(SignupFailed(Failure.message)),
      (userEntity) => emit(SignupSuccess(userEntity)),
    );
  }
}
