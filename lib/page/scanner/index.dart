import 'package:flutter/material.dart';

class LiveAttendence extends StatefulWidget {
  final int? colorperusahaan;
  const LiveAttendence({Key? key, this.colorperusahaan}) : super(key: key);

  @override
  State<LiveAttendence> createState() => _LiveAttendenceState();
}

class _LiveAttendenceState extends State<LiveAttendence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorperusahaan == null
            ? Color(widget.colorperusahaan!)
            : const Color(0xFF0D1037),
        title: const Text("Live Attendance",
            style: TextStyle(color: Colors.white)),
        leading: const BackButton(color: Colors.white),
      ),
      body: Text(""),
    );
  }
}
