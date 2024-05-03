import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_cuibt.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_state.dart';
import 'package:hamazh_auth/data/models/user_model.dart';
import 'package:hamazh_auth/utls/base_widget/text_form_widget.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';
import 'package:hamazh_auth/view/auth/login_Screen.dart';

import 'confirmation_otp.dart';
import '../../utls/base_widget/base_widget.dart';
import '../../utls/helper/crypto_helper.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/fonts_manger.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController name;
  late TextEditingController phoneNumber;
  late TextEditingController email;
  String codeCountry = "+2";
  @override
  void initState() {
    name = TextEditingController();
    phoneNumber = TextEditingController();
    email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phoneNumber.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          "Sign up",
          style: FontsManger.blackFont(context)
              .copyWith(color: ColorsManger.white, fontSize: 20),
        ),
        backgroundColor: ColorsManger.pColor.withOpacity(.8),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
              style: FontsManger.largeFont(context).copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter your information to continue signUp",
              style: FontsManger.mediumFont(context).copyWith(
                  fontSize: 12, color: ColorsManger.black.withOpacity(.6)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              controller: name,
              hint: "Please enter full name",
              prefix: const Icon(Icons.person),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              controller: email,
              hint: "Please enter Email address",
              prefix: const Icon(Icons.email),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              controller: phoneNumber,
              hint: "Please enter phone number",
              prefix: const Icon(Icons.phone),
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
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthCuibt, AuthState>(builder: (context, state) {
              return ElevatedButton(
                  onPressed: () async {
                    UserModel user = UserModel(
                        id: "",
                        name: name.text,
                        email: email.text,
                        phone: "$codeCountry${phoneNumber.text}");
                    context.appCuibt
                        .verifyPhoneNumber(
                          context: context,
                          phone: "$codeCountry${phoneNumber.text}",
                        )
                        .then((value) => navigatorWid(
                            page: ConfirmationOtpScreen(
                              phone: "$codeCountry${phoneNumber.text}",
                              user: user,
                            ),
                            context: context,
                            returnPage: true));
                  },
                  child: context.appCuibt.loading
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.black,
                        )
                      : const Text("Sign Up"));
            }),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "do you have account",
                    style:
                        FontsManger.smallFont(context).copyWith(fontSize: 12)),
                TextSpan(
                  text: " Sign in",
                  style: FontsManger.smallFont(context)
                      .copyWith(fontSize: 12, color: ColorsManger.pColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigatorWid(
                          page: const LoginScreen(),
                          context: context,
                          returnPage: false);
                    },
                ),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
