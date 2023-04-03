import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/auth/signup/components/area_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';

class AreaDropdown extends StatelessWidget {
  const AreaDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryStatesService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const AreaDropdownPopup();
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedArea),
      ),
    );
  }
}
