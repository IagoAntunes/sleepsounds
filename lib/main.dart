import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sleepsounds/core/utils/app_injects.dart';
import 'package:sleepsounds/src/features/home/presenter/pages/home_page.dart';
import 'package:sleepsounds/src/features/intro/intro_page.dart';

import 'core/theme/color_schemes.g.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Inject.setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SleepSounds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: _decideRoute() ? HomePage() : const IntroPage(),
    );
  }

  bool _decideRoute() {
    return GetIt.I.get<FirebaseAuth>().currentUser != null;
  }
}
