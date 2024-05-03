import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/view/auth/login_Screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../data/local_data.dart';
import '../../data/models/user_model.dart';
import '../../utls/base_widget/base_widget.dart';
import '../../utls/helper/crypto_helper.dart';
import 'auth_state.dart';
import '../../view/auth/confirmation_otp.dart';

class AuthCuibt extends Cubit<AuthState> {
  AuthCuibt() : super(AppInitial());
  UserModel? user;
  bool loading = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticateWifBiometrics = false;
  bool canAuthenticate = false;

  void isCanAuth() async {
    canAuthenticateWifBiometrics = await auth.canCheckBiometrics;
    canAuthenticate =
        canAuthenticateWifBiometrics || await auth.isDeviceSupported();
    emit(IsCanAuth());
  }

  void createAccount(UserModel userNew, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userNew.id)
        .set(userNew.toMap())
        .then((value) async {})
        .catchError((error) {
      print("error $error");
    });
  }

  Future<UserModel> getInfo(uid, BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      emit(GetInfo());
      return UserModel.fromJson(value.data()!);
    });
  }

  String codeSent = "";
  Future verifyPhoneNumber({
    required BuildContext context,
    required String phone,
  }) async {
    loading = true;
    emit(Loading());
    int? forceResendingToken;
    return await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: forceResendingToken,
        phoneNumber: phone,
        verificationCompleted: (credential) async {},
        verificationFailed: (verificationFailed) {
          MotionToast.error(
            description: Text(verificationFailed.toString()),
            title: const Text("error"),
          ).show(context);
        },
        codeSent: (verificationId, resendingToken) {
          codeSent = verificationId;
          forceResendingToken = resendingToken;
          loading = false;
          emit(Loading());
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
          codeSent = codeAutoRetrievalTimeout;
        },
        timeout: const Duration(seconds: 60));
  }

  Future<void> signWithPhone(BuildContext context, String otp,
      String phoneNumber, UserModel? user) async {
    try {
      loading = true;
      emit(Loading());
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: codeSent,
        smsCode: otp,
      ))
          .then((value) async {
        SharedPreference.setDate(key: "phone", value: phoneNumber);
        if (value.additionalUserInfo!.isNewUser) {
          UserModel newUser = UserModel(
              id: value.user!.uid,
              name: CryptoHelper().encrypt(inputString: user?.name ?? ""),
              email: CryptoHelper().encrypt(inputString: user?.email ?? ""),
              phone: CryptoHelper().encrypt(inputString: user?.phone ?? ""));
          createAccount(newUser, context);
          MotionToast.success(
            description: const Text("you signUp successfully"),
            onClose: () {
              navigatorWid(page: const LoginScreen(), context: context);
            },
          ).show(context);
        } else {
          MotionToast.success(
            description: const Text("you Sign IN successfully"),
            onClose: () {
              navigatorWid(page: const LoginScreen(), context: context);
            },
          ).show(context);
        }
        getInfo(value.user?.uid, context).then((value) {});
        loading = false;
        emit(Loading());
      });
    } catch (e) {
      print("e${e}");
      loading = false;
      emit(Loading());
      MotionToast.error(
        description: Text(e.toString()),
        title: const Text("error"),
      ).show(context);
    }
  }
}
