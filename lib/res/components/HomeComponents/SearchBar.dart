// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../TextFromFeilds/CustomaizedField.dart';

class HomeSearchBar extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  VoidCallback ontap;
  HomeSearchBar(
      {super.key, required this.searchController, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: Row(
        children: [
          Expanded(
            child: CustomizedFeild(
              controller: searchController,
              hint: 'Search',
            ),
          ),
          0.01.pw,
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: Container(
              height: Get.height * 0.05,
              width: Get.width * 0.20,
              decoration: BoxDecoration(
                color: AppColor.redColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Search',
                  style: GoogleFonts.poppins(
                      color: AppColor.whiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
