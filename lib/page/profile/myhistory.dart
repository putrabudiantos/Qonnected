import 'package:flutter/material.dart';

class MyHistory extends StatefulWidget {
  final String? urlimages;
  final String? gender;
  final String? nama;
  final String? jabatan;
  final String? namaperusahaan;
  final String? date;
  final String? status;
  final String? hour;
  const MyHistory({
    Key? key,
    this.urlimages,
    this.gender,
    this.nama,
    this.jabatan,
    this.namaperusahaan,
    this.date,
    this.status,
    this.hour,
  }) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    String? urlimagess = widget.urlimages;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          bannerProfiles(
              heights: .3,
              urlimages: urlimagess,
              gender: widget.gender != null ? "${widget.gender}" : "-"),
          // Info user dibawah foto gender pada tab profile
          const SizedBox(height: 46),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                widget.gender != null
                    ? Text("${widget.nama} Activity",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                    : const Text("-"),
                const SizedBox(height: 25),
                DefaultTabController(
                    length: 4, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: const TabBar(
                              labelColor: Color(0xFF0D1037),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'Terlambat'),
                                Tab(text: 'WFH'),
                                Tab(text: 'IZIN'),
                                Tab(text: 'CUTI'),
                              ],
                            ),
                          ),
                          Container(
                              height: 400, //height of TabBarView
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(children: <Widget>[
                                Container(
                                    child: ListView(
                                  children: [listtilerlambat()],
                                )),
                                Container(
                                    child: ListView(
                                  children: [listtilewfh()],
                                )),
                                Container(
                                    child: ListView(
                                  children: [listtileizin()],
                                )),
                                Container(
                                    child: ListView(
                                  children: [listtilecuti()],
                                )),
                              ]))
                        ])),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget bannerProfiles({String? urlimages, double? heights, String? gender}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * heights!,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: urlimages == null
                  ? const NetworkImage(
                      'https://akcdn.detik.net.id/community/media/visual/2022/09/22/ilustrasi-legalitas-perusahaan_169.jpeg?w=700&q=90')
                  : NetworkImage(urlimages),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            right: 10,
            top: 25,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
        Positioned.fill(
          bottom: -40,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image(
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    image: gender == "laki-laki"
                        ? const AssetImage('assets/icons/male.png')
                        : const AssetImage('assets/icons/female.png')),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // fungsi untuk listile terlambat
  Widget listtilerlambat() {
    return Column(
      children: [
        ListTile(
            textColor: Colors.black,
            title: Text("WFO pada tanggal ${widget.date}"),
            subtitle: Text(
              "Check In : ${widget.hour}",
            )),
        const Divider()
      ],
    );
  }

  // fungsi untuk listile wfh
  Widget listtilewfh() {
    return Column(
      children: [
        ListTile(title: Text("WFH pada tanggal ${widget.date}")),
        const Divider()
      ],
    );
  }

  // fungsi untuk listile izin
  Widget listtileizin() {
    return Column(
      children: [
        ListTile(title: Text("IZIN pada tanggal ${widget.date}")),
        const Divider()
      ],
    );
  }

  // fungsi untuk listile cuti
  Widget listtilecuti() {
    return Column(
      children: [
        ListTile(title: Text("CUTI pada tanggal ${widget.date}")),
        const Divider()
      ],
    );
  }
}
