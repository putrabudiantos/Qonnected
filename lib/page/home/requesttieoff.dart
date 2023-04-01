import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: const Text('A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void requestingform({BuildContext? context, TextEditingController? alasanC}) {
  showDialog(
    context: context!,
    builder: (_) {
      return AlertDialog(
        title: const Text('Contact Us'),
        content: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: alasanC,
              decoration: const InputDecoration(hintText: 'Alasan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Send them to your email maybe?
              Navigator.pop(context);
            },
            child: TextButton(onPressed: () {}, child: const Text('Submit')),
          ),
        ],
      );
    },
  );
}
