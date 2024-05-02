import 'package:flutter/material.dart';

extension Ispassword on String {
  bool get isPassword {
    if (length >= 8 &&
        contains(RegExp(r'[A-Z]')) &&
        contains(RegExp(r'[a-z]')) &&
        contains(RegExp(r'[0-9]'))) {
      return false;
    } else {
      return true;
    }
  }
}

extension Isemail on String {
  bool get isEmail {
    if (contains(RegExp(r'@')) && contains(RegExp(r'\.'))) {
      return false;
    } else {
      return true;
    }
  }
}

extension Isphone on String {
  bool get isPhoneNumber {
    if (length == 11 && contains(RegExp(r'[0-9]')) && startsWith('01')) {
      return false;
    } else {
      return true;
    }
  }
}
extension Height on BuildContext {
  double get height {
    return MediaQuery
        .of(this)
        .size
        .height;
  }
}
extension Width on BuildContext {
  double get width {
    return MediaQuery
        .of(this)
        .size
        .width;
  }
}
