import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class IndexScanner extends StatefulWidget {
  const IndexScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndexScannerState();
}

class _IndexScannerState extends State<IndexScanner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () async {
      await Permission.camera.request();
      String? barcode = await scanner.scan();
    });
  }
}
