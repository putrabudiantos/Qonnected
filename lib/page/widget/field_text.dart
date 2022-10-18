import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qonnected_app/global_variabel.dart' as vars;

class FieldText extends StatefulWidget {
  FieldText(
      {required this.textfield,
      required this.placeholder,
      required this.errorMessage,
      required this.customController,
      required this.customType,
      required this.readonly,
      Key? key})
      : super(key: key);
  final String placeholder, errorMessage, textfield;
  final TextEditingController customController;
  final bool customType, readonly;
  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          obscureText: widget.customType,
          controller: widget.customController,
          style: GoogleFonts.inter(
            color: Color(0xFF0D1037),
            textStyle: Theme.of(context).textTheme.bodyMedium,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          // initialValue: widget.labeltext,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.placeholder,
              hintStyle: GoogleFonts.inter(
                color: Color(0xFF0D1037),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D1037), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D1037), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.errorMessage;
            } else if (value.length > 256) {
              return 'Max number of characters 256';
            }
            return null;
          },
        ),
      ],
    );
  }
}
