import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamazh_auth/utls/base_widget/base_widget.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/utls/manger/assets_manger.dart';
import 'package:hamazh_auth/utls/manger/color_manger.dart';

import '../auth/login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    // timer to show the splash Screen and navigator to auth Screen
    timer=Timer(const Duration(seconds: 2), () {
navigatorWid(page: const LoginScreen(), context: context);
    });
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(AssetsManger.logo,height: context.height*.3,width: context.width*.8,),
          ),
          const CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
