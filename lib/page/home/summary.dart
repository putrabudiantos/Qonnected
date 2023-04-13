import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Summary {
  final String country;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  Summary({
    required this.country,
    required this.newConfirmed,
    required this.totalConfirmed,
    required this.newDeaths,
    required this.totalDeaths,
    required this.newRecovered,
    required this.totalRecovered,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      country: json['Country'],
      newConfirmed: json['NewConfirmed'],
      totalConfirmed: json['TotalConfirmed'],
      newDeaths: json['NewDeaths'],
      totalDeaths: json['TotalDeaths'],
      newRecovered: json['NewRecovered'],
      totalRecovered: json['TotalRecovered'],
    );
  }
}

Future<List<Summary>> fetchSummary() async {
  final response =
      await http.get(Uri.parse('https://api.covid19api.com/summary'));

  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);
    List jsonResponse = parsed["Countries"] as List;
    return jsonResponse.map((job) => Summary.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load Data');
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final controller = ScrollController();
  double offset = 0;

  late Future<List<Summary>> _func;

  @override
  void initState() {
    _func = fetchSummary();
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Summary>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<Summary> data = snapshot.data!;
            // print(data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  banner(),
                  const SizedBox(height: 20),
                  const Text(
                    "Nama Perusahaan",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  infoSummary(),
                  const SizedBox(height: 20),

                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("Hari Efektif Kerja",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey.shade300),
                              sortColumnIndex: 0,
                              sortAscending: true,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'No.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  numeric: false,
                                  tooltip: "Country Name",
                                ),
                                DataColumn(
                                  label: Text(
                                    'Bulan',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  numeric: true,
                                  tooltip: "Total Confirmed",
                                ),
                                DataColumn(
                                  label: Text(
                                    'Jumlah',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  numeric: true,
                                  tooltip: "New Confirmed",
                                ),
                                DataColumn(
                                  label: Text(
                                    'Tahun',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  numeric: true,
                                  tooltip: "Total Deaths",
                                ),
                                DataColumn(
                                  label: Text(
                                    'Telat',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  numeric: true,
                                  tooltip: "New Deaths",
                                ),
                              ],
                              rows: data
                                  .map(
                                    (country) => DataRow(
                                      cells: [
                                        DataCell(
                                          Container(
                                            color: Colors.transparent,
                                            width: 100,
                                            child: Text(
                                              country.country,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            color: Colors.transparent,
                                            width: 60.0,
                                            child: Center(
                                              child: Text(
                                                country.totalConfirmed
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              country.newConfirmed.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              country.totalDeaths.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              country.newDeaths.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          )),
                        ),
                      ])),
                  // SizedBox(height: 500),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text(
                'An Error Occured!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
                style: const TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.transparent,
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase,
                      colors: [
                        Colors.blue.shade800,
                        Colors.red,
                        Colors.pink,
                        Colors.green
                      ],
                      strokeWidth: 2,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.black),
                )),
                const SizedBox(height: 20),
                const Text('Loading..')
              ],
            ),
          );
        },
      ),
    );
  }

  Widget banner({String? url}) {
    return Stack(children: [
      if (url != null)
        Image.network(url)
      else
        Image.network(
            'https://akcdn.detik.net.id/community/media/visual/2022/09/22/ilustrasi-legalitas-perusahaan_169.jpeg?w=700&q=90'),
      Positioned(
          top: 30,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ))
    ]);
  }

  Container infoSummary({String? hariEfektif, String? hariLibur}) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [Text(hariEfektif ?? '0'), const Text("Hari Efektif")],
            ),
            const VerticalDivider(color: Colors.black26, thickness: 2),
            Column(
              children: [Text(hariLibur ?? '0'), const Text("Hari Libur")],
            )
          ],
        ),
      ),
    );
  }
}
