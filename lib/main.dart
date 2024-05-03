import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_cuibt.dart';
import 'package:hamazh_auth/utls/theme/light_theme.dart';
import 'package:hamazh_auth/view/splash/splash_Screen.dart';

import 'data/local_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreference.init();
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
    return BlocProvider(
      create: (context) => AuthCuibt(),
      child: MaterialApp(
        title: 'Auth test',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
