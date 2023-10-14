// ignore_for_file: non_constant_identifier_names

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Colors/AppColor.dart';

class Utils {
  //app Bar design
  static PreferredSizeWidget appBar(var title) {
    return AppBar(
      backgroundColor: AppColor.whiteColor,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.redColor,
        ),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.redColor,
          )),
      centerTitle: true,
    );
  }

  // DialogBox
  static void DialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            height: Get.height * 0.40,
            width: Get.width * 0.70,
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                0.03.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    0.03.pw,
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.check_circle,
                        size: 27,
                        color: AppColor.whiteColor,
                      ),
                    )
                  ],
                ),
                0.04.ph,
                Text(
                  'Successfull!',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                0.01.ph,
                Text(
                  'Your Order is Placed Successfully',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColor.geryColor,
                          fontWeight: FontWeight.normal)),
                ),
                0.05.ph,
                MaterialButton(
                  minWidth: Get.width * 0.45,
                  height: Get.height * 0.06,
                  color: AppColor.redColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Get.offAllNamed(RoutesNames.bottomScreen);
                  },
                  child: Text(
                    'Continue Shopping',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Date and Time Conversion
  static String convertDate(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM:dd:yyyy').format(dateTime).toString();
  }
}
