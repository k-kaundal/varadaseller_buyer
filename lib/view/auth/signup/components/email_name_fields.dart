// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/custom_input.dart';

import '../../../utils/common_helper.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields(
      {Key? key,
      this.fullNameController,
      this.userNameController,
      this.emailController})
      : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Name ============>
          CommonHelper().labelCommon(ConstString.fullName),

          CustomInput(
            controller: fullNameController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterFullName);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterFullName),
            icon: 'assets/icons/user.png',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 18,
          ),

          //User name ============>
          CommonHelper().labelCommon(ConstString.userName),

          CustomInput(
            controller: userNameController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterUsername);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterUsername),
            icon: 'assets/icons/user.png',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 18,
          ),

          //Email ============>
          CommonHelper().labelCommon(ConstString.email),

          CustomInput(
            controller: emailController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterEmail);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterYourEmail),
            icon: 'assets/icons/email-grey.png',
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
