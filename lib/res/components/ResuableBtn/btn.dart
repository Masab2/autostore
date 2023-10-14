// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class Btn extends StatelessWidget {
  String title;
  VoidCallback ontap;
  Color? color;
  Btn({super.key, required this.title, required this.ontap, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Get.width * 0.30,
      color: color,
      onPressed: ontap,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold, color: AppColor.whiteColor),
      ),
    );
  }
}
