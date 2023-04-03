import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/components/state_dropdown_popup.dart';

class StateDropdown extends StatelessWidget {
  const StateDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryStatesService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const StateDropdownPopup();
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedState),
      ),
    );
  }
}
