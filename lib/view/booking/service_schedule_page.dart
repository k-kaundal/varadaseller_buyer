import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/booking_services/shedule_service.dart';
import 'package:qixer/service/common_service.dart';

import 'package:qixer/view/booking/delivery_address_page.dart.dart';

import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'components/steps.dart';

class ServiceSchedulePage extends StatefulWidget {
  const ServiceSchedulePage({Key? key}) : super(key: key);

  @override
  _ServiceSchedulePageState createState() => _ServiceSchedulePageState();
}

class _ServiceSchedulePageState extends State<ServiceSchedulePage> {
  @override
  void initState() {
    super.initState();
  }

  int selectedShedule = 0;
  var _selectedWeekday;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return WillPopScope(
      onWillPop: () {
        BookStepsService().decreaseStep(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarForBookingPages('Schedule', context),
        body: Consumer<SheduleService>(
          builder: (context, provider, child) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: physicsCommon,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Circular Progress bar
                          Steps(cc: cc),

                          DatePicker(
                            DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            selectionColor: cc.primaryColor,
                            selectedTextColor: Colors.white,
                            onDateChange: (value) {
                              // New date selected
                              setState(() {
                                _selectedWeekday = firstThreeLetter(value);
                              });

                              print(_selectedWeekday);
                              //fetch shedule
                              Provider.of<SheduleService>(context,
                                      listen: false)
                                  .fetchShedule(2, _selectedWeekday);
                            },
                          ),

                          // Time =============================>
                          const SizedBox(
                            height: 30,
                          ),
                          CommonHelper().titleCommon('Available time:'),

                          const SizedBox(
                            height: 17,
                          ),
                          provider.isloading == false
                              ? provider.schedules != 'nothing'
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 45,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        clipBehavior: Clip.none,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  provider.schedules.schedules
                                                      .length;
                                              i++)
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {
                                                setState(() {
                                                  selectedShedule = i;
                                                });
                                              },
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 17,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: selectedShedule ==
                                                                    i
                                                                ? cc
                                                                    .primaryColor
                                                                : cc
                                                                    .borderColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 13,
                                                        vertical: 15),
                                                    child: Text(
                                                      provider
                                                          .schedules
                                                          .schedules[i]
                                                          .schedule,
                                                      style: TextStyle(
                                                        color: cc.greyFour,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  selectedShedule == i
                                                      ? Positioned(
                                                          right: 10,
                                                          top: -7,
                                                          child: CommonHelper()
                                                              .checkCircle())
                                                      : Container()
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Text(
                                      "No shedule available on this date",
                                      style: TextStyle(color: cc.primaryColor),
                                    )
                              : OthersHelper().showLoading(cc.primaryColor),
                        ],
                      )),
                ),
              ),

              //  bottom container
              Container(
                padding: EdgeInsets.only(
                    left: screenPadding, top: 20, right: screenPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 8,
                      blurRadius: 17,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CommonHelper().titleCommon('Scheduling for:'),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // BookingHelper().rowLeftRight(
                      //     'assets/svg/calendar.svg',
                      //     'Date',
                      //     'Friday, 18 March 2022'),
                      // const SizedBox(
                      //   height: 14,
                      // ),
                      // BookingHelper().rowLeftRight(
                      //     'assets/svg/clock.svg',
                      //     'Time',
                      //     '02:00 PM -03:00 PM'),
                      // const SizedBox(
                      //   height: 23,
                      // ),
                      CommonHelper().buttonOrange("Next", () {
                        //increase page steps by one
                        BookStepsService().onNext(context);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const DeliveryAddressPage()));
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
