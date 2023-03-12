import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/profile_edit_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/custom_input.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController postCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String? countryCode;

  @override
  void initState() {
    super.initState();
    countryCode = Provider.of<ProfileService>(context, listen: false)
        .profileDetails
        .userDetails
        .countryCode;
    //set country code
    Future.delayed(const Duration(milliseconds: 600), () {
      Provider.of<ProfileEditService>(context, listen: false)
          .setCountryCode(countryCode);
    });

    fullNameController.text =
        Provider.of<ProfileService>(context, listen: false)
                .profileDetails
                .userDetails
                .name ??
            '';
    emailController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .email ??
        '';

    phoneController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .phone ??
        '';
    postCodeController.text =
        Provider.of<ProfileService>(context, listen: false)
                .profileDetails
                .userDetails
                .postCode ??
            '';
    addressController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .address ??
        '';
  }

  late AnimationController localAnimationController;
  XFile? pickedImage;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(ConstString.editProfile, context, () {
        if (Provider.of<ProfileEditService>(context, listen: false).isloading ==
            false) {
          Navigator.pop(context);
        } else {
          OthersHelper()
              .showToast(ConstString.plzWaitProfileUpdating, Colors.black);
        }
      }),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Consumer<AppStringService>(
          builder: (context, ln, child) => Consumer<ProfileEditService>(
            builder: (context, provider, child) => WillPopScope(
              onWillPop: () {
                if (provider.isloading == false) {
                  // Provider.of<CountryStatesService>(context, listen: false)
                  //     .setStateAndAreaValueToDefault();
                  return Future.value(true);
                } else {
                  OthersHelper().showToast(
                      ln.getString(ConstString.plzWaitProfileUpdating),
                      Colors.black);
                  return Future.value(false);
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //pick profile image
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          pickedImage = await provider.pickImage();
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 105,
                          height: 105,
                          child: Stack(
                            children: [
                              Consumer<ProfileService>(
                                builder: (context, profileProvider, child) =>
                                    Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: pickedImage == null
                                          ? profileProvider.profileImage != null
                                              ? CommonHelper().profileImage(
                                                  profileProvider.profileImage,
                                                  85,
                                                  85)
                                              : Image.asset(
                                                  'assets/images/avatar.png',
                                                  height: 85,
                                                  width: 85,
                                                  fit: BoxFit.cover,
                                                )
                                          : Image.file(
                                              File(pickedImage!.path),
                                              height: 85,
                                              width: 85,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              ),
                              Positioned(
                                bottom: 9,
                                right: 12,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                      child: Icon(
                                    Icons.camera,
                                    color: cc.greyPrimary,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //Email, name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Name ============>
                          CommonHelper()
                              .labelCommon(ln.getString(ConstString.fullName)),

                          CustomInput(
                            controller: fullNameController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.enterFullName);
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

                          //Email ============>
                          CommonHelper()
                              .labelCommon(ln.getString(ConstString.email)),

                          CustomInput(
                            controller: emailController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.plzEnterEmail);
                              }
                              return null;
                            },
                            hintText: ConstString.enterEmail,
                            icon: 'assets/icons/email-grey.png',
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),

                      //phone
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper()
                              .labelCommon(ln.getString(ConstString.phone)),
                          Consumer<RtlService>(
                            builder: (context, rtlP, child) => IntlPhoneField(
                              controller: phoneController,
                              decoration: SignupHelper().phoneFieldDecoration(
                                  labelText:
                                      ln.getString(ConstString.phoneNumber),
                                  hintText: ln
                                      .getString(ConstString.enterPhoneNumber)),
                              initialCountryCode: countryCode,
                              disableLengthCheck: true,
                              textAlign: rtlP.direction == 'ltr'
                                  ? TextAlign.left
                                  : TextAlign.right,
                              onChanged: (phone) {
                                provider.setCountryCode(phone.countryISOCode);
                              },
                            ),
                          ),
                          sizedBoxCustom(20),
                          CommonHelper()
                              .labelCommon(ln.getString(ConstString.postCode)),
                          CustomInput(
                            controller: postCodeController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.plzEnterPost);
                              }
                              return null;
                            },
                            isNumberField: true,
                            hintText: ln.getString(ConstString.enterPostCode),
                            icon: 'assets/icons/user.png',
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),

                      //dropdowns
                      const CountryStatesDropdowns(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          CommonHelper().labelCommon(
                              ln.getString(ConstString.yourAddress)),
                          TextareaField(
                            hintText: ln.getString(ConstString.address),
                            notesController: addressController,
                          ),
                        ],
                      ),

                      //About
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          CommonHelper()
                              .labelCommon(ln.getString(ConstString.about)),
                          TextareaField(
                            hintText: ln.getString(ConstString.about),
                            notesController: aboutController,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      CommonHelper().buttonOrange(
                          ln.getString(ConstString.save), () async {
                        var selectedStateId = Provider.of<CountryStatesService>(
                                context,
                                listen: false)
                            .selectedStateId;
                        var selectedAreaId = Provider.of<CountryStatesService>(
                                context,
                                listen: false)
                            .selectedAreaId;
                        if (selectedStateId == '0' || selectedAreaId == '0') {
                          OthersHelper().showSnackBar(
                              context,
                              ln.getString(ConstString.mustSelectStateArea),
                              cc.warningColor);
                          return;
                        } else if (provider.isloading == false) {
                          if (addressController.text.isEmpty) {
                            OthersHelper().showToast(
                                ln.getString(ConstString.addressRequired),
                                Colors.black);
                            return;
                          } else if (phoneController.text.isEmpty) {
                            OthersHelper().showToast(
                                ln.getString(ConstString.phoneRequired),
                                Colors.black);
                            return;
                          }
                          showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: ln.getString(
                                    ConstString.updateProfileTakeFewSec),
                              ),
                              persistent: true,
                              onAnimationControllerInit: (controller) =>
                                  localAnimationController = controller,
                              onTap: () {
                                // localAnimationController.reverse();
                              });

                          //update profile
                          var result = await provider.updateProfile(
                            fullNameController.text,
                            emailController.text,
                            phoneController.text,
                            selectedStateId,
                            selectedAreaId,
                            Provider.of<CountryStatesService>(context,
                                    listen: false)
                                .selectedCountryId,
                            postCodeController.text,
                            addressController.text,
                            aboutController.text,
                            pickedImage?.path,
                            context,
                          );
                          if (result == true || result == false) {
                            localAnimationController.reverse();
                          }
                        }
                      }, isloading: provider.isloading == false ? false : true),

                      const SizedBox(
                        height: 38,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
