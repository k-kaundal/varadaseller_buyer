import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/const_strings.dart';

class SellerDetails extends StatelessWidget {
  const SellerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<OrderDetailsService>(
        builder: (context, provider, child) => Column(
          children: [
            provider.orderDetails.sellerDetails != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper().titleCommon(
                              ln.getString(ConstString.sellerDetails)),
                          const SizedBox(
                            height: 25,
                          ),
                          //Service row

                          Container(
                            child: BookingHelper().bRow(
                                'null',
                                ln.getString(ConstString.name),
                                provider.orderDetails.sellerDetails.name),
                          ),

                          Container(
                            child: BookingHelper().bRow(
                                'null',
                                ln.getString(ConstString.email),
                                provider.orderDetails.sellerDetails.email),
                          ),

                          Container(
                            child: BookingHelper().bRow(
                                'null',
                                ln.getString(ConstString.phone),
                                provider.orderDetails.sellerDetails.phone),
                          ),
                          provider.orderDetails.isOrderOnline == 0
                              ? Container(
                                  child: BookingHelper().bRow(
                                      'null',
                                      ln.getString(ConstString.postCode),
                                      provider.orderDetails.sellerDetails
                                              .postCode ??
                                          ''),
                                )
                              : Container(),
                          provider.orderDetails.isOrderOnline == 0
                              ? Container(
                                  child: BookingHelper().bRow(
                                      'null',
                                      ln.getString(ConstString.address),
                                      provider.orderDetails.sellerDetails
                                              .address ??
                                          "",
                                      lastBorder: false),
                                )
                              : Container(),
                        ]),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
