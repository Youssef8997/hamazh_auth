import 'package:flutter/material.dart';

class FontsManger{
  static TextStyle smallFont(context)=>Theme.of(context).textTheme.displaySmall!;
  static TextStyle mediumFont(context)=>Theme.of(context).textTheme.displayMedium!;
  static TextStyle largeFont(context)=>Theme.of(context).textTheme.displayLarge!;
  static TextStyle semiBoldFont(context)=>Theme.of(context).textTheme.titleLarge!;
  static TextStyle blackFont(context)=>Theme.of(context).textTheme.bodyLarge!;
}

class  WeightManger{
  static const FontWeight bold=FontWeight.bold;
  static const FontWeight regular=FontWeight.w400;
  static const FontWeight medium=FontWeight.w500;
  static const FontWeight semiBold=FontWeight.w600;
  static const FontWeight black=FontWeight.w900;
}