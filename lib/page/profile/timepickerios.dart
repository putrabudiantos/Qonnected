import 'package:flutter/cupertino.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime date = DateTime(2016, 10, 26);
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  /* 
  CupertinoDatePicker(
                        initialDateTime: time,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        // This is called when the user changes the time.
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => time = newTime);
                        },
                      ),
                    ),
                    // In this example, the time value is formatted manually.
                    // You can use the intl package to format the value based on
                    // the user's locale settings.
                    child: Text(
                      '${time.hour}:${time.minute}',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
  */
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
