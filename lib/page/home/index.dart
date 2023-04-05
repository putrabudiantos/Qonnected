import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/home/payslip.dart';
import 'package:qonnected_app/page/home/story.dart';
import 'package:qonnected_app/page/home/timeoff.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/page/home/todayactivity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  ActivityController homeC = Get.put(ActivityController());
  ProfileController profileC = Get.put(ProfileController());
  ScrollController? controller;
  bool kondisiekspanded = false;

  int get count => list.length;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  List<int> list = [];

  @override
  void initState() {
    // service.initialize();
    super.initState();
    // Noti.initialize(flutterLocalNotificationsPlugin);
    // list.addAll(List.generate(30, (v) => v));
  }

  void load() {
    print("load");
    setState(() {
      list.addAll(List.generate(15, (v) => v));
      print("data count = ${list.length}");
    });
  }

  Future<bool> loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    list.clear();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        const SizedBox(height: 20),

        //Fungsi ini untuk memasukan logo perusanhaan
        buttonlogoperusahaan(
            urlimage:
                "https://media.licdn.com/dms/image/C560BAQEAUSqLfGDgLQ/company-logo_200_200/0/1593420726726?e=2147483647&v=beta&t=OfLy2pp1FTmLtJqj_SffcjCuip8J3KxHKBF-0Cf7HZ4"),
        if (kondisiekspanded == true) menulogo() else const SizedBox(height: 5),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 23, right: 23),
          child: Text("Our Stories",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),

        // untuk Strory perusahaan
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              StoryPerusahaan(),
              StoryPerusahaan(),
              StoryPerusahaan(),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20, left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Today's Activity",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black26,
              ),
            ],
          ),
        ),

        // Aktifitas harian karyawan
        todaysActivity(
            name: "Putra",
            gender: "laki-laki",
            status: "wfh",
            date: DateFormat.yMMMEd().format(DateTime.now())),
        todaysActivity(
            name: "Arum",
            gender: "perempuan",
            status: "wfo",
            date: DateFormat.yMMMEd().format(DateTime.now())),
      ]),
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
            iconCard(
                text: 'Pay Slip',
                img: 'assets/images/icon/icon-06.png',
                function: () {
                  Get.to(const PaySlip());
                }),
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

  Widget buttonlogoperusahaan({String? urlimage}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          kondisiekspanded = !kondisiekspanded;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: Image.network("$urlimage"),
      ),
    );
  }

// Row untuk menu saat logo perusahaan ditekan
  Widget menulogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          imagedatacontainer(
              function: () {},
              urlassets: "assets/icons/revisi/attendance.png",
              nama: "Summary"),
          imagedatacontainer(
              function: () {
                Get.to(const TimeOff());
              },
              urlassets: "assets/icons/revisi/history.png",
              nama: "Time Off"),
          imagedatacontainer(
              function: () {
                Get.to(const PaySlip());
              },
              urlassets: "assets/icons/revisi/payslip2.png",
              nama: "PaySlip")
        ],
      ),
    );
  }

  GestureDetector imagedatacontainer(
      {String? urlassets, Function()? function, String? nama}) {
    return GestureDetector(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                urlassets!,
                scale: 6,
              ),
              const SizedBox(height: 10),
              Text(nama!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }
}
