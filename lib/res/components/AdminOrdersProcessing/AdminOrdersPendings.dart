// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class AdminOrdersDetails extends StatelessWidget {
  VoidCallback ontap;
  String customername, image, price, address, time, customerId;
  AdminOrdersDetails(
      {super.key,
      required this.customername,
      required this.image,
      required this.price,
      required this.ontap,
      required this.time,
      required this.customerId,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: InkWell(
        onTap: ontap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(customerId,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColor.geryColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  height: Get.height * 0.20,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(image: AssetImage(image))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  height: Get.height * 0.20,
                  width: Get.width / 2.2,
                  // color: AppColor.geryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customername,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: AppColor.geryColor,
                              fontWeight: FontWeight.bold)),
                      0.01.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$price Rs',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: AppColor.redColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      0.01.ph,
                      Text(address.toUpperCase(),
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        height: Get.height * 0.05,
                        width: Get.width * 0.40,
                        decoration: const BoxDecoration(
                          color: AppColor.geryColor,
                        ),
                        child: Center(
                          child: Text(time,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.whiteColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            0.02.ph,
            const Divider(
              thickness: 2.0,
              endIndent: 20,
              indent: 20,
              color: AppColor.geryColor,
            )
          ],
        ),
      ),
    );
  }
}
