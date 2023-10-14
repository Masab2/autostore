// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class CartContainer extends StatelessWidget {
  String title, price, quantity, image;
  CartContainer({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
      height: Get.height * 0.13,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            spreadRadius: 5.0,
            offset: Offset(
              5.0,
              5.0,
            ),
          )
        ],
      ),
      child: Row(
        children: [
          0.02.pw,
          CachedNetworkImage(
            height: 100,
            width: 100,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.03.ph,
                Text(title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  children: [
                    Text(price,
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColor.geryColor)),
                    0.07.pw,
                    Text("$quantity X",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColor.redColor))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
