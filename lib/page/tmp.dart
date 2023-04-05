import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:getx_tutorials/models/opensea_model.dart';

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

// contoh get api dengan GETX
class OpenseaModel {
  OpenseaModel({
    required this.assets,
  });

  List<Assets>? assets;

  OpenseaModel.fromJson(Map<String, dynamic> json) {
    assets = List.from(json['assets']).map((e) => Assets.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['assets'] = assets!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Assets {
  Assets({
    required this.imageUrl,
    required this.name,
    this.description,
    required this.permalink,
  });

  String? imageUrl;
  String? name;
  String? description;
  String? permalink;

  Assets.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    description = null;
    permalink = json['permalink'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['name'] = name;
    _data['description'] = description;
    _data['permalink'] = permalink;
    return _data;
  }
}

class OpenseaController extends GetxController {
  var isLoading = false.obs;
  OpenseaModel? openseaModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://api.opensea.io/api/v1/assets?collection=cryptopunks')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);

        openseaModel = OpenseaModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}

class GetAPI extends StatelessWidget {
  final openseaController = Get.put(OpenseaController());

  GetAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('opensea Api')),
        body: Obx(
          () => openseaController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount:
                      openseaController.openseaModel?.assets?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(openseaController
                                .openseaModel?.assets![index].name ??
                            'no name'),
                        subtitle: Text(openseaController
                                .openseaModel?.assets![index].description ??
                            'no description'),
                        leading: openseaController
                                    .openseaModel?.assets![index].imageUrl ==
                                null
                            ? const Icon(Icons.image)
                            : Image.network(openseaController
                                .openseaModel!.assets![index].imageUrl!),
                        onTap: () {
                          _launchInBrowser(Uri.parse(openseaController
                              .openseaModel!.assets![index].permalink!));
                        });
                  }),
        ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
