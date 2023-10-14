// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utility/Colors/AppColor.dart';

class BackGroundRow extends StatelessWidget {
  String page;
  String? title;
  BackGroundRow({super.key, required this.page, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        0.03.pw,
        InkWell(
          onTap: () {
            Get.offAndToNamed(page);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.redColor,
          ),
        ),
      ],
    );
  }
}
