// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../../../Utility/Colors/AppColor.dart';
import '../../../Utility/assets/ImageAsset.dart';

class HomeAppBar {
  static PreferredSizeWidget HomeBar(VoidCallback? ontap) {
    return AppBar(
      leading: IconButton(
        onPressed: ontap,
        icon: Image.asset(
          ImageAsset.categoryIcon,
          height: Get.height * 0.06,
          width: Get.width * 0.06,
          color: AppColor.redColor,
        ),
      ),
      title: RichText(
          text: TextSpan(
              text: 'CAR',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: AppColor.redColor,
                  fontWeight: FontWeight.bold),
              children: [
            TextSpan(
                text: 'Parts',
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    color: AppColor.geryColor,
                    fontWeight: FontWeight.normal))
          ])),
      centerTitle: true,
      actions: [
        StreamBuilder(
          stream: Apis.getCartProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              int itemCount = snapshot.data?.docs.length ?? 0;
              log(itemCount.toString());
              return itemCount > 0
                  ? badges.Badge(
                      badgeContent: Text(itemCount.toString(),
                          style: GoogleFonts.poppins(
                            color: AppColor.whiteColor,
                          )),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RoutesNames.cartScreen);
                        },
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 35,
                          color: AppColor.geryColor,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.toNamed(RoutesNames.cartScreen);
                      },
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: AppColor.geryColor,
                      ),
                    );
            }
          },
        ),
        0.05.pw
      ],
    );
  }
}
