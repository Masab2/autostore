// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class OrderInProgressComponents extends StatelessWidget {
  String title,
      image,
      quan,
      city,
      price,
      address,
      redBtntext,
      customerId,
      status;
  VoidCallback onRedBtn;
  OrderInProgressComponents(
      {super.key,
      required this.title,
      required this.image,
      required this.onRedBtn,
      required this.quan,
      required this.price,
      required this.redBtntext,
      required this.customerId,
      required this.status,
      required this.city,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: Column(
        children: [
          0.02.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Wrap(
              children: [
                Text("CustomerID :  ",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColor.redColor,
                        fontWeight: FontWeight.bold)),
                Text(customerId,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColor.geryColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          0.02.ph,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                height: Get.height * 0.20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    height: Get.height * 0.10,
                    width: Get.width / 2.9,
                    imageUrl: image,
                    placeholder: (context, url) => const SpinKitChasingDots(
                      color: AppColor.redColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                height: Get.height * 0.20,
                width: Get.width / 2.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Status :  ",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: AppColor.redColor,
                                fontWeight: FontWeight.bold)),
                        Text(status,
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColor.geryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    0.02.ph,
                    Text(title,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: AppColor.geryColor,
                            fontWeight: FontWeight.bold)),
                    0.02.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$quan X',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('$price Rs',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: AppColor.redColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    0.01.ph,
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Address : ${address}',
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          0.03.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    minWidth: Get.width * 0.30,
                    height: Get.height * 0.05,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: AppColor.redColor,
                    onPressed: onRedBtn,
                    child: Text(
                      redBtntext,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor),
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
    );
  }
}
