import 'package:flutter/material.dart';

class MainPageJobSeeker extends StatefulWidget {
  const MainPageJobSeeker({Key? key}) : super(key: key);

  @override
  State<MainPageJobSeeker> createState() => _MainPageJobSeekerState();
}

class _MainPageJobSeekerState extends State<MainPageJobSeeker> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: const Text(
          'Nabila Rahmadanti',
          style: TextStyle(color: Colors.black54, fontFamily: "Inter"),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/C5603AQEEZybzvKzFGQ/profile-displayphoto-shrink_800_800/0/1647222863743?e=2147483647&v=beta&t=x7oaQmzWAnuQlhBP-EZa1iIUGJWhCr_rFloLIPtQzdw'),
          )
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Cari Kerja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Kontak Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profil',
          ),
        ],
        currentIndex: selectedIndex,
        unselectedIconTheme: const IconThemeData(color: Colors.black38),
        selectedItemColor: Colors.blue.shade900,
        onTap: onItemTapped,
      ),
    );
  }
}
