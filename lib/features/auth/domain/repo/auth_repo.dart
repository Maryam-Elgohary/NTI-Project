import 'package:dartz/dartz.dart';
import 'package:forth_session/core/errors/failure.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> CreateUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, UserEntity>> SignWithEmailAndPassword(
    String email,
    String password,
  );
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uID});
  Future saveUserData({required UserEntity user});

  Future<void> SignOut();
}
