import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/page/activity/index.dart';
import 'package:qonnected_app/page/widget/bottom_navigation.dart';

class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  State<IndexHome> createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF2D2F48)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 80,
          ),
        ),
      ),
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
              Text("Today's Activities"),
              SizedBox(
                height: 10,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Get.to(IndexActivity());
              //     },
              //     child: Text('go')),
              Container(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        leading: Icon(Icons.person),
                        title: Text("Person's ${index}"),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavWidget(),
    );
  }
}
