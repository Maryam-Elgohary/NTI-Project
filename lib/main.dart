import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forth_session/core/bloc_observer.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/core/services/sharedPreference_singleton.dart';
import 'package:forth_session/core/utils/backend_endpoints.dart';
import 'package:forth_session/features/auth/domain/entities/user_entity.dart';
import 'package:forth_session/features/auth/presentation/views/signinview.dart';
import 'package:forth_session/firebase_options.dart';
import 'package:forth_session/generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  await SharPref.init();
  Bloc.observer = StateObserver();
  // to be able to use hive with flutter code
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());

  // get a space for a specific type of data in memory
   await Hive.openBox<UserEntity>(BackendEndpoints.hiveBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'), // Arabic locale
      debugShowCheckedModeBanner: false,
      home: Signinview(),
    );
  }
}
