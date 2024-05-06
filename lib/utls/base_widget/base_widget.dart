import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationNav extends PageRouteBuilder {
  final Widget page;

  AnimationNav({
    required this.page,
  }) : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionDuration: const Duration(
        milliseconds: 400,
      ),
      reverseTransitionDuration: const Duration(
        milliseconds: 400,
      ),
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {

        return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child);
      });
}

navigatorWid(
    {required Widget page,
      required BuildContext context,
      returnPage = false,
      arguments}) {
  return Navigator.pushAndRemoveUntil(
    context,
    AnimationNav(page: page),
        (Route route) => returnPage,
  );
}