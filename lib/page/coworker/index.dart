import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class IndexCoWorkers extends StatefulWidget {
  IndexCoWorkers({Key? key}) : super(key: key);

  @override
  State<IndexCoWorkers> createState() => _IndexCoWorkersState();
}

class _IndexCoWorkersState extends State<IndexCoWorkers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            CardList('lala', 'pos', 'masuk'),
            CardList('lala', 'pos', 'masuk'),
            CardList('lala', 'pos', 'masuk'),
            CardList('lala', 'pos', 'masuk'),
            CardList('lala', 'pos', 'masuk'),
            CardList('lala', 'pos', 'masuk'),
          ],
        ),
      )),
    );
  }

  Widget CardList(String name, String position, String status) {
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
                    color: Colors.green,
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
