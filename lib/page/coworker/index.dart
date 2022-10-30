import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;
import 'package:qonnected_app/global_variabel.dart';

class IndexCoWorkers extends StatefulWidget {
  IndexCoWorkers({Key? key}) : super(key: key);

  @override
  State<IndexCoWorkers> createState() => _IndexCoWorkersState();
}

class _IndexCoWorkersState extends State<IndexCoWorkers> {
  CoWorkersController workerC = Get.put(CoWorkersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => Wrap(
              children: [
                Center(
                    child: Text(workerC.companyName.value,
                        style: FontMedium(
                            context, 20, FontWeight.w800, Color(0xFF0D1037)))),
                SizedBox(
                  height: 50,
                ),
                for (var i = 0; i < workerC.coworkersModel.length; i++)
                  CardList(
                      workerC.coworkersModel.value[i].fullname!,
                      workerC.coworkersModel.value[i].position!,
                      workerC.coworkersModel.value[i].worker_status!),
              ],
            )),
      )),
    );
  }

  CardList(String name, String position, String status) {
    var act;
    if (status == 'wfo') {
      act = Colors.green;
    } else if (status == 'wfh') {
      act = Colors.blue;
    } else if (status == 'izin') {
      act = Colors.grey;
    } else if (status == 'cuti') {
      act = Colors.black;
    } else {
      act = Colors.red;
    }

    return Container(
        width: MediaQuery.of(context).size.width * .5 - 20,
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 50,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: vars.FontMedium(
                      context,
                      14,
                      FontWeight.w600,
                      Color(0xFF0D1037),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: act,
                  )
                ],
              ),
              Text(
                position,
                style: vars.FontMedium(
                  context,
                  10,
                  FontWeight.w500,
                  Color(0xFF0D1037),
                ),
              ),
            ]));
  }
}
