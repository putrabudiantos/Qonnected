import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static alertDialog(
      BuildContext context, String status, String message, bool showbutton) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        title: Icon(
          status == '200'
              ? Icons.check_circle_outline_outlined
              : Icons.error_outline,
          size: 80,
          color: status == '200' ? Colors.green : Colors.red.shade800,
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          showbutton == true
              ? TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Color(0xFF0D1037), fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
