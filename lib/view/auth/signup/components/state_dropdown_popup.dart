import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';

class StateDropdownPopup extends StatelessWidget {
  const StateDropdownPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetch country
    Provider.of<CountryStatesService>(context, listen: false)
        .fetchStates(context);

    final cc = ConstantColors();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<CountryStatesService>(
            builder: (context, p, child) => Column(
              children: [
                sizedBoxCustom(30),
                CustomInput(
                  hintText: 'Search country',
                  paddingHorizontal: 17,
                  icon: 'assets/icons/search.png',
                ),
                sizedBoxCustom(10),
                p.statesDropdownList.isNotEmpty
                    ? p.statesDropdownList[0] != ConstString.selectState
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: p.statesDropdownList.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  p.setStatesValue(p.statesDropdownList[i]);

//                         // setting the id of selected value
                                  p.setSelectedStatesId(
                                      p.statesDropdownIndexList[p
                                          .statesDropdownList
                                          .indexOf(p.statesDropdownList[i])]);

                                  Navigator.pop(context);
                                  p.setAreaDefault();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: cc.greyFive))),
                                  child: CommonHelper().paragraphCommon(
                                      '${p.statesDropdownList[i]}'),
                                ),
                              );
                            })
                        : CommonHelper()
                            .paragraphCommon(ConstString.noCityFound)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
