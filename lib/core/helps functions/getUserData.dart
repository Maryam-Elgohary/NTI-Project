import 'package:forth_session/core/utils/backend_endpoints.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

UserEntity getUser() {
  // var jsonString = SharPref.getString(BackendEndpoints.getUserDataFromLocal);
  // var userEntity = UserModel.fromJson(jsonDecode(jsonString)).toEntity();
  // return userEntity;

  final userBox = Hive.box<UserEntity>(BackendEndpoints.hiveBoxName);
  return userBox.get(BackendEndpoints.hiveUserBoxKey)!;
}
