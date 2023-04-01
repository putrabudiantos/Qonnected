import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qonnected_app/page/profile/listtile.dart';
import 'package:qonnected_app/page/profile/pengingatclockinlisttile.dart';
import 'package:qonnected_app/page/profile/pengingatclockoutlisttile.dart';

class Pengingat extends StatefulWidget {
  const Pengingat({Key? key}) : super(key: key);

  @override
  State<Pengingat> createState() => _PengingatState();
}

class _PengingatState extends State<Pengingat> {
  final listtiles = ListTiles();
  bool pengingathari = false;
  bool pengingatclockin = false;
  bool pengingatclockout = false;
  DateTime timeclockin = DateTime.now();
  DateTime timeclockout = DateTime.now();

  void showDialogTime(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Pengingat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: ListView(
          children: [
            listtiles.listtile(
                time: DateFormat('HH:mm').format(timeclockin),
                onchange: (bool? value) {
                  setState(() {
                    pengingatclockin = value ?? false;
                  });
                  if (value == true) {
                    showDialogTime(CupertinoDatePicker(
                      initialDateTime: timeclockin,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          timeclockin = newTime;
                        });
                      },
                    ));
                  }
                },
                text: "Pengingat Clock In",
                values: pengingatclockin),

            //Listtile untuk pengingat clockout
            listtiles.listtile(
                time: DateFormat('HH:mm').format(timeclockout),
                text: "Pengingat Clock Out",
                onchange: (bool? value) {
                  setState(() {
                    pengingatclockout = value ?? false;
                  });
                  if (value == true) {
                    showDialogTime(CupertinoDatePicker(
                      initialDateTime: timeclockout,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          timeclockout = newTime;
                        });
                      },
                    ));
                  }
                },
                values: pengingatclockout),

            //if true disyplay this
            pengingatclockin == true
                ? const ContainerPengingatClockIn()
                : const SizedBox.shrink(),

            pengingatclockout == true
                ? const ContainerPengingatClockOut()
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  ListTile pengingat(String? title, String? subtitle) {
    return ListTile(
      title: Text(
        title!,
        style: const TextStyle(
            fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle!),
    );
  }
}
