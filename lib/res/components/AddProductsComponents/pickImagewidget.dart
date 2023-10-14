// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class PickImageWidget extends StatelessWidget {
  VoidCallback ontap;
  PickImageWidget({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: Get.height * 0.20,
          width: Get.width * 0.60,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.redColor),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.camera,
                color: AppColor.redColor,
                size: 36,
              ),
              0.02.ph,
              Text(
                'Choose Image',
                style:
                    GoogleFonts.roboto(fontSize: 18, color: AppColor.redColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
