import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';

import '../../utls/base_widget/text_form_widget.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/fonts_manger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController passWord = TextEditingController();
  String codeCountry = "+2";

  @override
  void dispose() {
    phoneNumber.dispose();
    passWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  toolbarHeight: 40,
  title: Text("Sign in",style: FontsManger.blackFont(context).copyWith(color: ColorsManger.white,fontSize: 20),),
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
        ElevatedButton(
            onPressed: () {
             /* context.authCubit.login(
                  context: context,
                  pass: passWord.text,
                  code: codeCountry,
                  phone: phoneNumber.text);*/
            },
            child: Text("continue")),
            SizedBox(
              height: context.height * .05,
            ),
            Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Don't have account",
                    style: FontsManger.smallFont(context).copyWith(fontSize: 12)),
                TextSpan(
                  text: " Sign up",
                  style: FontsManger.smallFont(context)
                      .copyWith(fontSize: 12, color:  ColorsManger.pColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //navigatorWid(page: const SignUpScreen(), context: context);
                    },
                ),
              ])),
            ),
            SizedBox(
              height: context.height * .02,
            ),
            Center(
              child: TextButton.icon(onPressed: (){

              }, icon: const Icon(Icons.fingerprint), label: Text("Use fingerPrint"))),


          ],
        ),
      ),
    );
  }
}
