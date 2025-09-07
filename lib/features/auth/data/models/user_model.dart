import 'package:firebase_auth/firebase_auth.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';

class UserModel {
  String? uID;
  String? email;
  String? name;

  UserModel({required this.uID, required this.email, required this.name});

  factory UserModel.userFromFirebase(User user) {
    return UserModel(
      uID: user.uid ?? '',
      email: user.email ?? "",
      name: user.displayName ?? "",
    );
  }

  factory UserModel.FromEnitity(UserEntity userEntity) {
    return UserModel(
      uID: userEntity.uid,
      email: userEntity.email,
      name: userEntity.name,
    );
  }

  UserEntity toEntity() {
    return UserEntity(name: name!, email: email!, uid: uID!);
  }

  toJson() {
    return {'uID': uID, 'email': email, 'name': name};
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uID: data['uID'],
      email: data['email'],
      name: data['name'],
    );
  }
}
