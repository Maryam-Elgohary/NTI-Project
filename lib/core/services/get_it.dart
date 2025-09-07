import 'package:dio/dio.dart';
import 'package:forth_session/core/services/FireStoreService.dart';
import 'package:forth_session/core/services/api_services.dart';
import 'package:forth_session/core/services/dataBaseService.dart';
import 'package:forth_session/core/services/firebaseAuth_service.dart';
import 'package:forth_session/features/auth/data/repos/AuthRepoImple.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:forth_session/features/home/data/repos/product_repo_implementation.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DataBaseService>(Firestoreservice());
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplementation(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      dataBaseService: getIt<DataBaseService>(),
    ),
  );
  getIt.registerSingleton<ProductRepo>(
    ProductRepoImplementation(apiServices: getIt<ApiServices>()),
  );
}
