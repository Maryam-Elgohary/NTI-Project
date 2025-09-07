import 'dart:convert';

import 'package:forth_session/core/services/sharedPreference_singleton.dart';
import 'package:forth_session/core/utils/backend_endpoints.dart';
import 'package:forth_session/features/auth/data/models/user_model.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';

UserEntity getUser() {
  var jsonString = SharPref.getString(BackendEndpoints.getUserDataFromLocal);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString)).toEntity();
  return userEntity;
}
