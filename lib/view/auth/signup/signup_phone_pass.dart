import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/auth/login_helper.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';

import '../../utils/constant_colors.dart';
import '../../utils/custom_input.dart';
import '../reset_password/reset_pass_otp_pass.dart';

class SignupPhonePass extends StatefulWidget {
  const SignupPhonePass({Key? key}) : super(key: key);

  @override
  _SignupPhonePassState createState() => _SignupPhonePassState();
}

class _SignupPhonePassState extends State<SignupPhonePass> {
  late bool _newpasswordVisible;
  late bool _repeatnewpasswordVisible;

  @override
  void initState() {
    super.initState();
    _newpasswordVisible = false;
    _repeatnewpasswordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController repeatNewPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//New password =========================>
            CommonHelper().labelCommon("Password"),

            Container(
                margin: const EdgeInsets.only(bottom: 19),
                decoration: BoxDecoration(
                    // color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: newPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: !_newpasswordVisible,
                  style: const TextStyle(fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 22.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/lock.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _newpasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _newpasswordVisible = !_newpasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().greyFive),
                          borderRadius: BorderRadius.circular(9)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().redColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().primaryColor)),
                      hintText: 'Enter password',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18)),
                )),

            //Repeat New password =========================>
            CommonHelper().labelCommon("Repeat password"),

            Container(
                margin: const EdgeInsets.only(bottom: 19),
                decoration: BoxDecoration(
                    // color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: repeatNewPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: !_repeatnewpasswordVisible,
                  style: const TextStyle(fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please retype your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 22.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/lock.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _repeatnewpasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _repeatnewpasswordVisible =
                                !_repeatnewpasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().greyFive),
                          borderRadius: BorderRadius.circular(9)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().redColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ConstantColors().primaryColor)),
                      hintText: 'Enter password',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18)),
                )),

            //Login button ==================>
            const SizedBox(
              height: 13,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {}
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ResetPassOtpPage(),
                  ),
                );
              },
              child: CommonHelper().buttonOrange('Continue'),
            ),

            const SizedBox(
              height: 25,
            ),
            SignupHelper().haveAccount(context),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
