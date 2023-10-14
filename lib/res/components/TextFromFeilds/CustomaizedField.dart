// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizedFeild extends StatelessWidget {
  String? title;
  String? hint;
  Widget? sufixIcon;
  Widget? prefixIcon;
  bool? obscuretext = false;
  VoidCallback? onchanged;
  TextEditingController controller;
  int maxlines;
  CustomizedFeild(
      {super.key,
      this.title,
      this.onchanged,
      required this.controller,
      this.hint,
      this.sufixIcon,
      this.prefixIcon,
      this.maxlines = 1,
      this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title ?? "",
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            )
          ],
        ),
        0.01.ph,
        Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.geryColor.withOpacity(0.34)),
          child: TextFormField(
            controller: controller,
            obscureText: obscuretext ?? false,
            maxLines: maxlines,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: sufixIcon),
          ),
        ),
      ],
    );
  }
}
