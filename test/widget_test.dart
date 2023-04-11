// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:qonnected_app/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  await getDataUser();
}

Future<ProfilesModels> getDataUser() async {
  var headers = {
    'Authorization': 'Token adCrbmpXTUpcMokI7OkivNC71QgsV067',
    'Cookie': 'route=1681096813.535.308.981237|1f6839247221289d5dff78ead76ea2bb'
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.baserow.io/api/database/rows/table/154795/1/?user_field_names=true'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
  return ProfilesModels.fromJson(
      jsonDecode(await response.stream.bytesToString()));
}

class ProfilesModels {
  final String fullname;
  final String phone;
  final String position;

  const ProfilesModels({
    required this.fullname,
    required this.phone,
    required this.position,
  });

  factory ProfilesModels.fromJson(Map<String, dynamic> json) {
    return ProfilesModels(
      fullname: json['fullname'],
      phone: json['phone'],
      position: json['position'],
    );
  }
}
