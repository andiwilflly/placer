import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.maxLines,
    // required this.validator,
  }) : super(key: key);

  final String hintText;
  final int? maxLines;
  final String? Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        maxLines: maxLines == null ? 1 : maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hintText.tr, // Added this
          contentPadding: EdgeInsets.only(left: 10, top: 10), // Added this
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text'.tr;
          }
          return null;
        });
  }
}
