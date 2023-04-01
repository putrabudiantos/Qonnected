// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// void calendar(BuildContext? context, Function? setState) {
//   CalendarFormat calendarFormat = CalendarFormat.month;
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDay;
//   final kToday = DateTime.now();
//   final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
//   final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
//   showModalBottomSheet(
//     isDismissible: false,
//     isScrollControlled: true,
//     context: context!,
//     enableDrag: true,
//     builder: (context) {
//       return FractionallySizedBox(
//         heightFactor: 0.9,
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//               color: Colors.white),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 color: Colors.transparent,
//                 child: Container(
//                   width: 60,
//                   height: 8,
//                   decoration: BoxDecoration(
//                       color: Colors.black12,
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TableCalendar(
//                 firstDay: kFirstDay,
//                 lastDay: kLastDay,
//                 focusedDay: focusedDay,
//                 calendarFormat: calendarFormat,
//                 selectedDayPredicate: (day) {
//                   // Use `selectedDayPredicate` to determine which day is currently selected.
//                   // If this returns true, then `day` will be marked as selected.

//                   // Using `isSameDay` is recommended to disregard
//                   // the time-part of compared DateTime objects.
//                   return isSameDay(selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(selectedDay, selectedDay)) {

//                     // Call `setState()` when updating the selected day
//                     setState(() {
//                       selectedDay = selectedDay;
//                       focusedDay = focusedDay;
//                     });
//                   }
//                 },
//                 onFormatChanged: (format) {
//                   if (calendarFormat != format) {

//                     // Call `setState()` when updating calendar format
//                     setState(() {
//                       calendarFormat = format;
//                     });
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   // No need to call `setState()` here
//                   focusedDay = focusedDay;
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
