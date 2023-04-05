// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';


// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: Test(),
// //     );
// //   }
// // }

// // class Test extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: FutureBuilder(
// //         future: http.get('https://dc-apps.net/map/services.json'),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           List data = json.decode(snapshot.data.body);
// //           // print(data);
// //           List categoriesnames = [];
// //           List stores = [];
// //           data.forEach((element) {
// //             categoriesnames.add(element["Category"]);
// //             stores.add(element['stores']);
// //           });

// //           // return Text('see');
// //           return ListView.builder(
// //             itemCount: data.length,
// //             itemBuilder: (context, index) {
// //               //      print(stores[index][index]['name']);
// //               return CardItem(
// //                 categoryname: categoriesnames[index],
// //                 sotories: stores[index],
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class CardItem extends StatelessWidget {
// //   final String categoryname;
// //   List sotories;
// //   CardItem({this.categoryname, this.sotories});
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Expanded(
// //         child: Column(
// //           children: [
// //             Text(categoryname),
// //             SizedBox(
// //               height: 5,
// //             ),
// //             ListView.builder(
// //               scrollDirection: Axis.vertical,
// //               shrinkWrap: true,
// //               itemCount: sotories.length,
// //               itemBuilder: (context, index) => ListTile(
// //                 title: Text(sotories[index]['name']),
// //                 subtitle: Column(
// //                   children: [
// //                     Text(sotories[index]['phone_1']),
// //                     Text(sotories[index]['phone_2']),
// //                   ],
// //                 ),
// //                 trailing: CircleAvatar(
// //                   radius: 50,
// //                   backgroundImage: NetworkImage(sotories[index]['logo_url']),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tab inside body widget',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tabs Example'),
//       ),
//       body: Container(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
//           SizedBox(height: 20.0),
//           Text('Tabs Inside Body', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
//           DefaultTabController(
//             length: 4, // length of tabs
//             initialIndex: 0,
//             child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
//               Container(
//                 child: TabBar(
//                   labelColor: Colors.green,
//                   unselectedLabelColor: Colors.black,
//                   tabs: [
//                     Tab(text: 'Tab 1'),
//                     Tab(text: 'Tab 2'),
//                     Tab(text: 'Tab 3'),
//                     Tab(text: 'Tab 4'),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 400, //height of TabBarView
//                 decoration: BoxDecoration(
//                   border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
//                 ),
//                 child: TabBarView(children: <Widget>[
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 1', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Text('Display Tab 4', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ])
//               )
//             ])
//           ),
//         ]),
//       ),
//     );
//   }
// }