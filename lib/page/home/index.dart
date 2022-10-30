import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/global_variabel.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';

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
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Color(0xFF2D2F48)),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Center(
      //     child: Image.asset(
      //       'assets/images/logo.png',
      //       height: 80,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
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
                              DateTime.parse(homeC
                                  .activityModel.value[index].date
                                  .toString()));
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
                          return homeC.activityModel.value[index].category !=
                                  'wfo'
                              ? ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Icon(Icons.person),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${homeC.activityModel.value[index].name} ${homeC.activityModel.value[index].category!.toUpperCase()}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: ' pada tanggal ${date}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              : Container();
                        })
                    : Container(
                        child: Text('Belum ada aktifitas',
                            style: FontMedium(context, 12, FontWeight.w500,
                                Color(0xFF0D1037))),
                      )),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //   onPressed: () {},
      //   child: Icon(Icons.qr_code_scanner), //icon inside button
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // // bottomNavigationBar: BottomNavWidget(),
    );
  }
}
