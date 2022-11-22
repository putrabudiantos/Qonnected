import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/controller/profile_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/service/local_notification.dart';

class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  ActivityController homeC = Get.put(ActivityController());
  ProfileController profileC = Get.put(ProfileController());
  int get count => list.length;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<int> list = [];

  void initState() {
    // service.initialize();
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
    // list.addAll(List.generate(30, (v) => v));
  }

  void load() {
    print("load");
    setState(() {
      list.addAll(List.generate(15, (v) => v));
      print("data count = ${list.length}");
    });
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    list.clear();
    load();
  }

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
                    height: MediaQuery.of(context).size.height * .26,
                    decoration: BoxDecoration(
                      color: Color(0xFF0D1037),
                    ),
                  ),
                  Positioned.fill(
                      bottom: -90,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: WidgetStats())),
                ],
              ),
              DisplayActivities()
            ]),
      ),
    );
  }

  Widget WidgetStats() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
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
                        Text(profileC.coworkersModel.value[0].fullname!,
                            style: vars.FontHeading(
                                context, 20, FontWeight.w800, Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(profileC.coworkersModel.value[0].position!,
                            style: vars.FontHeading(
                                context, 15, FontWeight.w500, Colors.white))
                      ],
                    ),
                  ),
                ),
                SizedBox(
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
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/icon/profile.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CardWidget(),
          ],
        ),
      ),
    );
  }

  Widget CardWidget() {
    return Container(
      // width: MediaQuery.of(context).size.width * 1,
      child: Card(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Noti.showBigTextNotification(
                      title: "New message title",
                      body: "Your long body",
                      fln: flutterLocalNotificationsPlugin);
                },
                child: IconCard('Calendar', 'assets/images/icon/icon-03.png')),
            IconCard('Time Off', 'assets/images/icon/icon-04.png'),
            IconCard('Overtime', 'assets/images/icon/icon-05.png'),
            IconCard('Pay Slip', 'assets/images/icon/icon-06.png'),
          ],
        ),
      ),
    );
  }

  Widget IconCard(String text, String img) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                img,
                width: 25,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: vars.FontHeading(
                    context, 11, FontWeight.w500, Color(0xFF0D1037)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayActivities() {
    return Container(
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
                  "Today's Activities",
                  style: FontMedium(
                      context, 15, FontWeight.w600, Color(0xFF0D1037)),
                )),
            SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Get.to(IndexActivity());
            //     },
            //     child: Text('go')),
            Container(
              child: Obx(() => homeC.activityModel.value.length > 0
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeC.activityModel.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        var date = DateFormat('dd MMM yyyy').format(
                            DateTime.parse(homeC.activityModel.value[index].date
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
                        } else if (homeC.activityModel.value[index].category ==
                            'wfh') {
                          act = Colors.blue;
                        } else if (homeC.activityModel.value[index].category ==
                            'izin') {
                          act = Colors.grey;
                        } else if (homeC.activityModel.value[index].category ==
                            'cuti') {
                          act = Colors.black;
                        } else {
                          act = Colors.red;
                        }
                        var tempAct;
                        var activities = ListTile(
                            dense: true,
                            contentPadding:
                                EdgeInsets.only(left: 0.0, right: 0.0),
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            leading: Icon(Icons.person),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: act,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${homeC.activityModel.value[index].name} ${homeC.activityModel.value[index].category!.toUpperCase()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' pada tanggal ${date}'),
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
                      child: Text('Belum ada aktifitas',
                          style: FontMedium(
                              context, 12, FontWeight.w500, Color(0xFF0D1037))),
                    )),
            )
          ],
        ),
      ),
    );
  }
}
