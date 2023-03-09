import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class OverviewBox extends StatelessWidget {
  const OverviewBox({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.withOpacity(.5)),
      ),
      child: Consumer<AppStringService>(
        builder: (context, ln, child) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CommonHelper().paragraphCommon(ln.getString(title), fontsize: 13),

          sizedBoxCustom(7),

          //amount
          CommonHelper().titleCommon(ln.getString(subtitle), fontsize: 15)
        ]),
      ),
    );
  }
}
