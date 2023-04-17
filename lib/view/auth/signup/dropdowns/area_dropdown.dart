import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/area_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_states_dropdowns.dart';

class AreaDropdown extends StatelessWidget {
  const AreaDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AreaDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          // p.fetchArea(context, isrefresh: true);
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
