import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:qonnected_app/global_variabel.dart' as vars;

class FieldEmail extends StatefulWidget {
  const FieldEmail(
      {required this.textfield,
      required this.placeholder,
      required this.errorMessage,
      required this.customController,
      required this.readonly,
      Key? key})
      : super(key: key);
  final String placeholder, errorMessage, textfield;
  final TextEditingController customController;
  final bool readonly;
  @override
  State<FieldEmail> createState() => _FieldEmailState();
}

class _FieldEmailState extends State<FieldEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.textfield != ''
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(widget.textfield,
                    style: vars.FontHeading(
                        context, 12, FontWeight.w600, Colors.white)))
            : Container(),
        TextFormField(
          readOnly: widget.readonly,
          onSaved: (value) {
            widget.customController.text = value!;
          },
          controller: widget.customController,
          // initialValue: widget.labeltext,
          style: GoogleFonts.inter(
            color: const Color(0xFF0D1037),
            textStyle: Theme.of(context).textTheme.bodyMedium,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.placeholder,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF0D1037),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF0D1037), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF0D1037), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.errorMessage;
            } else if (value.length > 256) {
              return 'Max number of characters 256';
            } else if (!EmailValidator.validate(value, true)) {
              return 'Email is not a valid email.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
