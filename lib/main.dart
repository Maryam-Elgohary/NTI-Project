import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forth_session/core/bloc_observer.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/core/services/sharedPreference_singleton.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';
import 'package:forth_session/firebase_options.dart';
import 'package:forth_session/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  await SharPref.init();
  Bloc.observer = StateObserver();
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
      home: Homeview(),
    );
  }
}
