import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/home/timeoff.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:table_calendar/table_calendar.dart';

class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  ActivityController homeC = Get.put(ActivityController());
  ProfileController profileC = Get.put(ProfileController());
  // int get count => list.length;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  List<int> list = [];

  @override
  void initState() {
    // service.initialize();
    super.initState();
    // Noti.initialize(flutterLocalNotificationsPlugin);
    // list.addAll(List.generate(30, (v) => v));
  }

  // void load() {
  //   print("load");
  //   setState(() {
  //     list.addAll(List.generate(15, (v) => v));
  //     print("data count = ${list.length}");
  //   });
  // }

  // Future<bool> _loadMore() async {
  //   print("onLoadMore");
  //   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  //   load();
  //   return true;
  // }

  // Future<void> _refresh() async {
  //   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  //   list.clear();
  //   load();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 210,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D1037),
                    ),
                  ),
                  Positioned.fill(
                      bottom: -90,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: widgetStats())),
                ],
              ),
              // displayActivities()
            ]),
      ),
    );
  }

  Widget widgetStats() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.transparent,
        height: 260,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => profileC.isLoading.value == true
                            ? const Text('...')
                            : Text(profileC.coworkersModel.value[0].fullname!,
                                style: vars.FontHeading(context, 20,
                                    FontWeight.w800, Colors.white))),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(() => profileC.isLoading.value == true
                            ? const Text('...')
                            : Text(profileC.coworkersModel.value[0].position!,
                                style: vars.FontHeading(context, 15,
                                    FontWeight.w500, Colors.white)))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/person.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            cardWidget(),
          ],
        ),
      ),
    );
  }

  Widget cardWidget() {
    return Container(
      color: Colors.transparent,
      // width: MediaQuery.of(context).size.width * 1,
      child: Card(
        elevation: 4,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            iconCard(
                text: 'Calendar',
                img: 'assets/images/icon/icon-03.png',
                function: () {
                  CalendarFormat calendarFormat = CalendarFormat.month;
                  DateTime focusedDay = DateTime.now();
                  DateTime? selectedDay;
                  final kToday = DateTime.now();
                  final kFirstDay =
                      DateTime(kToday.year, kToday.month - 3, kToday.day);
                  final kLastDay =
                      DateTime(kToday.year, kToday.month + 3, kToday.day);
                  showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    context: context,
                    enableDrag: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.6,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Container(
                                  width: 60,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TableCalendar(
                                firstDay: kFirstDay,
                                lastDay: kLastDay,
                                focusedDay: focusedDay,
                                calendarFormat: calendarFormat,
                                selectedDayPredicate: (day) {
                                  // Use `selectedDayPredicate` to determine which day is currently selected.
                                  // If this returns true, then `day` will be marked as selected.

                                  // Using `isSameDay` is recommended to disregard
                                  // the time-part of compared DateTime objects.
                                  return isSameDay(selectedDay, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(selectedDay, selectedDay)) {
                                    // Call `setState()` when updating the selected day
                                    setState(() {
                                      selectedDay = selectedDay;
                                      focusedDay = focusedDay;
                                    });
                                  }
                                },
                                onFormatChanged: (format) {
                                  if (calendarFormat != format) {
                                    // Call `setState()` when updating calendar format
                                    setState(() {
                                      calendarFormat = format;
                                    });
                                  }
                                },
                                onPageChanged: (focusedDay) {
                                  // No need to call `setState()` here
                                  focusedDay = focusedDay;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            iconCard(
                text: 'Time Off',
                img: 'assets/images/icon/icon-04.png',
                function: () {
                  Get.to(const TimeOff());
                }),
            iconCard(text: 'Overtime', img: 'assets/images/icon/icon-05.png'),
            iconCard(text: 'Pay Slip', img: 'assets/images/icon/icon-06.png'),
          ],
        ),
      ),
    );
  }

  Widget iconCard({String? text, String? img, void Function()? function}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: function,
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  img!,
                  width: 25,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text!,
                  style: vars.FontHeading(
                      context, 12, FontWeight.w500, const Color(0xFF0D1037)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayActivities() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
            ),
            GestureDetector(
                onTap: () {
                  print(homeC.timeCompany.value);
                  var dateNow = DateFormat('dd-MM-yyyy').format(DateTime.parse(
                      homeC.activityModel.value[0].date.toString()));
                  final today = dateNow;

                  // homeC.fetchActivity();

                  //                 DateTime dt2 = DateTime.parse("${dateNow.toString()} ${homeC.timeCompany.value.toString()}");
                  //           DateTime a = dt2 as DateTime;
                  //                 print(a.add(Duration(minutes: 10)));

                  //         DateTime dt2 = DateTime.parse("${dateNow} ${homeC.timeCompany.value}");

                  //   if (dt1.compareTo(dt2) < 0) {
                  //     print("DT1 is before DT2");
                  //   }

                  //   if (dt1.compareTo(dt2) > 0) {
                  //     print("DT1 is after DT2");
                  //   }
                },
                child: Text(
                  "Aktifitas hari ini",
                  style: FontMedium(
                      context, 15, FontWeight.w600, const Color(0xFF0D1037)),
                )),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Get.to(IndexActivity());
            //     },
            //     child: Text('go')),
            Container(
              color: Colors.transparent,
              child: Obx(() => homeC.isLoading.value == true
                  ? Container()
                  : homeC.activityModel.value.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.grey,
                              ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeC.activityModel.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            var date = DateFormat('dd MMM yyyy').format(
                                DateTime.parse(homeC
                                    .activityModel.value[index].date
                                    .toString()));

                            //compare time

                            var dateNow = DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(
                                    DateTime.now().toLocal().toString()));
                            DateTime dt1 = DateTime.parse(
                                "${homeC.activityModel.value[index].date.toString()} ${homeC.activityModel.value[index].time_in.toString()}");
                            DateTime dt2 = DateTime.parse(
                                    "${dateNow.toString()} ${homeC.timeCompany.value}")
                                .add(Duration(minutes: homeC.timeOffset.value));

//                            DateTime dt2 = DateTime.parse('${homeC.activityModel.value[0].date
//                                 .toString()} ${homeC.timeCompany.value}');
// final fiftyDaysFromNow = dt1.add(Duration(minutes: homeC.timeOffset.value));

                            var act;
                            if (homeC.activityModel.value[index].category ==
                                'wfo') {
                              act = Colors.green;
                            } else if (homeC
                                    .activityModel.value[index].category ==
                                'wfh') {
                              act = Colors.blue;
                            } else if (homeC
                                    .activityModel.value[index].category ==
                                'izin') {
                              act = Colors.grey;
                            } else if (homeC
                                    .activityModel.value[index].category ==
                                'cuti') {
                              act = Colors.black;
                            } else {
                              act = Colors.red;
                            }
                            var tempAct;
                            var activities = ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0),
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                leading: const Icon(Icons.person),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: act,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${homeC.activityModel.value[index].name} ${homeC.activityModel.value[index].category!.toUpperCase()}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' pada tanggal $date'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));

                            if (homeC.activityModel.value[index].category ==
                                'wfo') {
                              if (dt1.compareTo(dt2) > 0) {
                                tempAct = activities;
                              } else {
                                tempAct = Container();
                              }
                            } else {
                              tempAct = activities;
                            }
                            return tempAct;
                          })
                      : Container(
                          color: Colors.transparent,
                          child: Text('Belum ada aktifitas',
                              style: FontMedium(context, 12, FontWeight.w500,
                                  const Color(0xFF0D1037))),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
