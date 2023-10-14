// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class PartsComponet extends StatelessWidget {
  String title, image, price, cat, but1, but2;
  VoidCallback ontap;
  VoidCallback? oncart;
  VoidCallback? onwishList;
  Widget? Btnred;
  Widget? Btngrey;

  PartsComponet(
      {super.key,
      required this.title,
      required this.image,
      this.oncart,
      required this.but1,
      required this.but2,
      required this.price,
      required this.ontap,
      this.onwishList,
      required this.cat,
      this.Btnred,
      this.Btngrey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
        child: Column(
          children: [
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
                  // color: AppColor.geryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: AppColor.geryColor,
                              fontWeight: FontWeight.bold)),
                      0.02.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${price} Rs',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: AppColor.redColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      0.01.ph,
                      Text('Category : ${cat}',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: Get.width * 0.30,
                    color: AppColor.geryColor,
                    onPressed: onwishList,
                    child: Text(
                      but1,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor),
                    ),
                  ),
                  MaterialButton(
                    minWidth: Get.width * 0.30,
                    color: AppColor.redColor,
                    onPressed: oncart,
                    child: Text(
                      but2,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor),
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
