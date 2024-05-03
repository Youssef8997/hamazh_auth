import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_cuibt.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_state.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/view/auth/sign_up_screen.dart';
import 'package:local_auth/local_auth.dart';

import '../../data/local_data.dart';
import '../../utls/base_widget/base_widget.dart';
import '../../utls/base_widget/text_form_widget.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/fonts_manger.dart';
import 'confirmation_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneNumber;
  String codeCountry = "+2";

  @override
  void initState() {
    context.appCuibt.isCanAuth();

    phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          "Sign in",
          style: FontsManger.blackFont(context)
              .copyWith(color: ColorsManger.white, fontSize: 20),
        ),
        backgroundColor: ColorsManger.pColor.withOpacity(.8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign in",
              style: FontsManger.largeFont(context).copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter your phone number",
              style: FontsManger.smallFont(context).copyWith(
                  fontSize: 18, color: ColorsManger.black.withOpacity(.8)),
            ),
            SizedBox(
              height: context.height * .036,
            ),
            TextFormWidget(
              controller: phoneNumber,
              hint: "Enter your phone number",
              textInputFormatter: [
                FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
              ],
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Icon(
                    Icons.person,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 1,
                    height: 17,
                    color: const Color(0xff9491BB),
                  )
                ],
              ),
              keyboardType: TextInputType.phone,
              suffixActive: CountryCodePicker(
                padding: EdgeInsets.zero,
                initialSelection: "+20",
                onChanged: (value) {
                  if (value.dialCode == "+20") {
                    codeCountry = "+2";
                  } else {
                    codeCountry = value.dialCode!;
                  }
                },
              ),
            ),
            SizedBox(
              height: context.height * .04,
            ),
            BlocBuilder<AuthCuibt, AuthState>(builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.appCuibt
                        .verifyPhoneNumber(
                            context: context,
                            phone: "${codeCountry}${phoneNumber.text}")
                        .then((value) async {
                      navigatorWid(
                          page: ConfirmationOtpScreen(
                            phone: "${codeCountry}${phoneNumber.text}",
                          ),
                          context: context,
                          returnPage: true);
                    });
                  },
                  child: context.appCuibt.loading
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.black,
                        )
                      : const Text("continue"));
            }),
            SizedBox(
              height: context.height * .05,
            ),
            Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Don't have account",
                    style:
                        FontsManger.smallFont(context).copyWith(fontSize: 12)),
                TextSpan(
                  text: " Sign up",
                  style: FontsManger.smallFont(context)
                      .copyWith(fontSize: 12, color: ColorsManger.pColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigatorWid(
                          page: const SignUpScreen(),
                          context: context,
                          returnPage: true);
                    },
                ),
              ])),
            ),
            SizedBox(
              height: context.height * .02,
            ),
            BlocBuilder<AuthCuibt, AuthState>(builder: (context, state) {
              return context.appCuibt.canAuthenticate
                  ? Center(
                      child: TextButton.icon(
                          onPressed: () async {
                            await context.appCuibt.auth
                                .authenticate(
                                    localizedReason:
                                        'Please authenticate to sign in to your account',
                                    options: const AuthenticationOptions(
                                      sensitiveTransaction: true,
                                      biometricOnly: true,
                                      stickyAuth: true,
                                    ))
                                .then((value) async {
                              if (value) {
                                context.appCuibt
                                    .verifyPhoneNumber(
                                        context: context,
                                        phone: await SharedPreference.getDate(
                                          key: "phone",
                                        ))
                                    .then((value) async {
                                  navigatorWid(
                                      page: ConfirmationOtpScreen(
                                        phone: await SharedPreference.getDate(
                                          key: "phone",
                                        ),
                                      ),
                                      context: context,
                                      returnPage: true);
                                });
                              }
                            });
                          },
                          icon: const Icon(Icons.fingerprint),
                          label: const Text("Use fingerPrint")))
                  : const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
