import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forth_session/core/errors/execptions.dart';
import 'package:forth_session/core/errors/failure.dart';
import 'package:forth_session/core/services/dataBaseService.dart';
import 'package:forth_session/core/services/firebaseAuth_service.dart';
import 'package:forth_session/core/utils/backend_endpoints.dart';
import 'package:forth_session/features/auth/data/models/user_model.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthRepoImplementation extends AuthRepo {
  AuthRepoImplementation({
    required this.firebaseAuthService,
    required this.dataBaseService,
  });
  final FirebaseAuthService firebaseAuthService;
  final DataBaseService dataBaseService;
  @override
  Future<Either<Failure, UserEntity>> CreateUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
      );
      // UserModel userModel = UserModel.userFromFirebase(user);
      UserEntity userEntity = UserEntity(
        name: name,
        email: email,
        uid: user.uid,
      );
      await addUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      return left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }

      log("Exception in createUSerWithEmailAndPassword: ${e.toString()}");
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> SignWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User user = await firebaseAuthService.signInWithEmailAndPassword(
        email,
        password,
      );

      var userEntity = await getUserData(uID: user.uid);
      await saveUserData(user: userEntity);
      // UserModel userModel = UserModel.userFromFirebase(user);
      // UserEntity userEntity = userModel.toEntity();
      // log(userEntity.uid);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await dataBaseService.addData(
      path: BackendEndpoints.addUserData,
      data: UserModel.FromEnitity(user).toJson(),
      docID: user.uid,
    );
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserEntity> getUserData({required String uID}) async {
    var data =
        await dataBaseService.getData(
              path: BackendEndpoints.getUserData,
              docID: uID,
            )
            as Map<String, dynamic>;
    UserModel userModel = UserModel.fromJson(data);
    UserEntity userEntity = userModel.toEntity();
    return userEntity;
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    //using shared pref to save user data locally
    // var jsonData = jsonEncode(UserModel.FromEnitity(user).toJson());
    // await SharPref.setString(BackendEndpoints.getUserDataFromLocal, jsonData);

    //using hive to save user data locally
    //make this box take user entity type and only this type
    var userBox = Hive.box<UserEntity>(BackendEndpoints.hiveBoxName);
    await userBox.put(BackendEndpoints.hiveUserBoxKey, user);
  }
}
