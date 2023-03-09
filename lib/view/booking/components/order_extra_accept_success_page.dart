import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';

class OrderExtraAcceptSuccessPage extends StatefulWidget {
  const OrderExtraAcceptSuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  _OrderExtraAcceptSuccessPageState createState() =>
      _OrderExtraAcceptSuccessPageState();
}

class _OrderExtraAcceptSuccessPageState
    extends State<OrderExtraAcceptSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  final cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon(ConstString.success, context, () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
            child: Consumer<AppStringService>(
          builder: (context, ln, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Container(
              height: screenHeight - 180,
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: cc.successColor,
                      size: 85,
                    ),
                    sizedBoxCustom(7),
                    Text(
                      ln.getString(ConstString.orderExtraAccepted),
                      style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 21,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ),
        )));
  }
}
