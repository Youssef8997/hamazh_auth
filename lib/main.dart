import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamazh_auth/utls/theme/light_theme.dart';
import 'package:hamazh_auth/view/splash/splash_Screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth test',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      home: const SplashScreen(),
    );
  }
}


