import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_states_dropdowns.dart';

class CountryDropdown extends StatelessWidget {
  final textWidth;
  const CountryDropdown({this.textWidth, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          // p.fetchCountries(context, isrefresh: true);
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const CountryDropdownPopup();
              });
        },
        child: dropdownPlaceholder(
            hintText: p.selectedCountry, textWidth: textWidth),
      ),
    );
  }
}
