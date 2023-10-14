// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utility/Colors/AppColor.dart';

class UserInfoContainer extends StatelessWidget {
  String title, subtitle;
  UserInfoContainer({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        children: [
          Container(
            height: Get.height * 0.12,
            width: Get.width * 0.26,
            decoration: BoxDecoration(
                color: AppColor.geryColor.withOpacity(0.23),
                borderRadius: BorderRadius.circular(44)),
            child: const Icon(
              FontAwesomeIcons.user,
              size: 28,
            ),
          ),
          Expanded(
            child: Container(
              height: Get.height * 0.13,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  0.03.ph,
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.geryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
