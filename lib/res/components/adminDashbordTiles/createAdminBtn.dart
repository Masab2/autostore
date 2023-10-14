// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class CreateAdminBtn extends StatelessWidget {
  VoidCallback ontap;
  String title;
  CreateAdminBtn({super.key, required this.ontap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          minWidth: Get.width * 0.35,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: AppColor.redColor,
          onPressed: ontap,
          child: Text(
            title,
            style: GoogleFonts.poppins(color: AppColor.whiteColor),
          ),
        ),
        0.02.ph,
      ],
    );
  }
}
