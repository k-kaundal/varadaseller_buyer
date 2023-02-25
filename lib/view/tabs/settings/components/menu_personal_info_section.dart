import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class MenuPersonalInfoSection extends StatelessWidget {
  const MenuPersonalInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<ProfileService>(
          builder: (context, profileProvider, child) => Container(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper()
                          .titleCommon(ln.getString("Personal informations")),
                      const SizedBox(
                        height: 25,
                      ),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("Email"),
                          profileProvider.profileDetails.userDetails.email ??
                              ''),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("City"),
                          profileProvider.profileDetails.userDetails.city
                                  .serviceCity ??
                              ''),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("Area"),
                          profileProvider.profileDetails.userDetails.area
                                  .serviceArea ??
                              ''),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("Country"),
                          profileProvider
                                  .profileDetails.userDetails.country.country ??
                              ''),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("Post Code"),
                          profileProvider.profileDetails.userDetails.postCode ??
                              ''),
                      BookingHelper().bRow(
                          'null',
                          ln.getString("Address"),
                          profileProvider.profileDetails.userDetails.address ??
                              '',
                          lastBorder: false),
                    ]),
              )),
    );
  }
}
