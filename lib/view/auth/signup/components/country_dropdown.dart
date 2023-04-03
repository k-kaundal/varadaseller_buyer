import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/auth/signup/components/country_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetch country
    Provider.of<CountryStatesService>(context, listen: false)
        .fetchCountries(context);

    return Consumer<CountryStatesService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const CountryDropdownPopup();
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedCountry),
      ),
    );
  }
}
