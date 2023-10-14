// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utility/Colors/AppColor.dart';

class PartsDetail extends StatelessWidget {
  String title;
  String? hint;
  IconData icon;
  int? maxlines;
  TextInputType? keyboardtype;
  TextEditingController controller;
  PartsDetail(
      {super.key,
      this.hint,
      required this.title,
      required this.icon,
      required this.controller,
      this.keyboardtype,
      this.maxlines});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 35,
          backgroundColor: AppColor.geryColor.withOpacity(0.23),
          child: Center(
              child: Icon(
            icon,
            size: 20,
            color: AppColor.redColor,
          )),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.redColor)),
            hintText: hint,
          ),
        ));
  }
}
