import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';

import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SignupHelper {
  ConstantColors cc = ConstantColors();
  haveAccount(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: '${ln.getString(ConstString.haveAnAccount)}  ',
              style: const TextStyle(color: Color(0xff646464), fontSize: 14),
              children: <TextSpan>[
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    text: ln.getString(ConstString.signIn),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: cc.primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  phoneFieldDecoration({required labelText, required hintText}) {
    return InputDecoration(
        labelText: labelText,
        // hintTextDirection: TextDirection.rtl,
        labelStyle: TextStyle(color: cc.greyFour, fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().greyFive),
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().warningColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors().primaryColor)),
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 18));
  }
}
