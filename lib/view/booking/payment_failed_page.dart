import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentFailedPageState createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Payment', context, () {
          Navigator.pop(context);
        }),
        body: WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Consumer<AppStringService>(
            builder: (context, ln, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 85,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: cc.successColor,
                        size: 85,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${ln.getString('Payment failed but order placed!')}!',
                    style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonHelper().paragraphCommon(
                      ln.getString(
                          'Payment failed but the order is placed. Payment status is pending. You can try to pay again from the orders page'),
                      textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
        ));
  }
}
