import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  ActivityController homeC = Get.put(ActivityController());
  int get count => list.length;

  List<int> list = [];

  void initState() {
    super.initState();
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
        child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .31,
                decoration: BoxDecoration(
                  color: Color(0xFF0D1037),
                ),
              ),
              Positioned.fill(
                  bottom: -90,
                  child: Align(
                      alignment: Alignment.bottomCenter, child: WidgetStats())),
            ],
          ),
          DisplayActivities()
        ]),
      ),
    );
  }

  Widget WidgetStats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CoWoker Name',
                          style: vars.FontHeading(
                              context, 20, FontWeight.w800, Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Position',
                          style: vars.FontHeading(
                              context, 15, FontWeight.w500, Colors.white))
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    image: NetworkImage(
                        'https://www.tutorialkart.com/img/hummingbird.png'),
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
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconCard('Calendar', Icons.file_present),
              IconCard('Time Off', Icons.file_present),
              IconCard('Overtime', Icons.file_present),
              IconCard('Pay Slip', Icons.file_present),
            ],
          ),
        ),
      ),
    );
  }

  Widget IconCard(String text, IconData customIcon) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                customIcon,
                size: 30,
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
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
            ),
            GestureDetector(
                onTap: () {
                  homeC.fetchActivity();
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
                        return ListTile(
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
