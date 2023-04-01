// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Test(),
//     );
//   }
// }

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder(
//         future: http.get('https://dc-apps.net/map/services.json'),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           List data = json.decode(snapshot.data.body);
//           // print(data);
//           List categoriesnames = [];
//           List stores = [];
//           data.forEach((element) {
//             categoriesnames.add(element["Category"]);
//             stores.add(element['stores']);
//           });

//           // return Text('see');
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               //      print(stores[index][index]['name']);
//               return CardItem(
//                 categoryname: categoriesnames[index],
//                 sotories: stores[index],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class CardItem extends StatelessWidget {
//   final String categoryname;
//   List sotories;
//   CardItem({this.categoryname, this.sotories});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Expanded(
//         child: Column(
//           children: [
//             Text(categoryname),
//             SizedBox(
//               height: 5,
//             ),
//             ListView.builder(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               itemCount: sotories.length,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text(sotories[index]['name']),
//                 subtitle: Column(
//                   children: [
//                     Text(sotories[index]['phone_1']),
//                     Text(sotories[index]['phone_2']),
//                   ],
//                 ),
//                 trailing: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(sotories[index]['logo_url']),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }