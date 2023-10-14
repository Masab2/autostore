// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utility/Colors/AppColor.dart';

class NavigationRow extends StatelessWidget {
  VoidCallback onback;
  Widget fav;
  NavigationRow({super.key, required this.onback, required this.fav});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: onback,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.redColor,
                size: 25,
              )),
          fav
        ],
      ),
    );
  }
}
