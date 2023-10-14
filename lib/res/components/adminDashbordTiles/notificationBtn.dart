// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class NotificationBtn extends StatelessWidget {
  String title;
  VoidCallback ontap;
  NotificationBtn({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      height: Get.height * 0.06,
      minWidth: Get.width * 0.60,
      color: AppColor.redColor,
      onPressed: ontap,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
