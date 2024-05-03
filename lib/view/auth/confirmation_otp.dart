import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_cuibt.dart';
import 'package:hamazh_auth/cuibt/auth_cuibt/auth_state.dart';
import 'package:hamazh_auth/data/models/user_model.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';

import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/fonts_manger.dart';

class ConfirmationOtpScreen extends StatefulWidget {
  final String phone;
  final UserModel? user;
  const ConfirmationOtpScreen({super.key, required this.phone, this.user});

  @override
  State<ConfirmationOtpScreen> createState() => _ConfirmationOtpScreenState();
}

class _ConfirmationOtpScreenState extends State<ConfirmationOtpScreen> {
  late TextEditingController otp;
  @override
  void initState() {
    otp = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    otp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: context.height * .12,
          ),
          SvgPicture.asset(
            AssetsManger.logo,
            width: context.width * .5,
            height: context.height * .07,
          ),
          SizedBox(
            height: context.height * .1,
          ),
          Center(
              child: Text(
            "You will receiver sms contain otp",
            style: FontsManger.largeFont(context)
                .copyWith(fontSize: 24, color: Colors.black),
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Waiting message on your phone number",
            style: FontsManger.mediumFont(context)
                .copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
          )),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: context.width,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xff707070))),
            child: PinCodeFields(
              controller: otp,
              fieldWidth: 20,
              length: 6,
              obscureText: true,
              onComplete: (String value) {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthCuibt, AuthState>(builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  context.appCuibt.signWithPhone(
                      context, otp.text, widget.phone, widget.user);
                },
                child: context.appCuibt.loading
                    ? CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.black,
                      )
                    : Text(
                        "Continue",
                        style: FontsManger.mediumFont(context)
                            .copyWith(fontSize: 16, color: Colors.white),
                      ));
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Change phoneNumber",
                    style: FontsManger.mediumFont(context)
                        .copyWith(fontSize: 14, color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    context.appCuibt.verifyPhoneNumber(
                        context: context, phone: widget.phone);
                  },
                  child: Text(
                    "Resend OTP",
                    style: FontsManger.mediumFont(context)
                        .copyWith(fontSize: 14, color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
