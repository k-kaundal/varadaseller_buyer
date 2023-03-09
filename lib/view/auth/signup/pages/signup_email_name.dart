// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/auth_services/signup_service.dart';
import 'package:qixer/view/auth/signup/components/email_name_fields.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/const_strings.dart';

class SignupEmailName extends StatefulWidget {
  const SignupEmailName(
      {Key? key,
      this.fullNameController,
      this.userNameController,
      this.emailController})
      : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;

  @override
  _SignupEmailNameState createState() => _SignupEmailNameState();
}

class _SignupEmailNameState extends State<SignupEmailName> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmailNameFields(
                  emailController: widget.emailController,
                  fullNameController: widget.fullNameController,
                  userNameController: widget.userNameController),
              const SizedBox(
                height: 18,
              ),

              //Login button ==================>
              const SizedBox(
                height: 13,
              ),
              Consumer<SignupService>(
                builder: (context, provider, child) => CommonHelper()
                    .buttonOrange(ln.getString(ConstString.continueTxt), () {
                  if (_formKey.currentState!.validate()) {
                    provider.pagecontroller.animateToPage(
                        provider.selectedPage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                }),
              ),

              const SizedBox(
                height: 25,
              ),
              SignupHelper().haveAccount(context),
            ],
          ),
        ),
      ),
    );
  }
}
