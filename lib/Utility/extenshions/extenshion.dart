// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension padding on num {
  SizedBox get ph => SizedBox(height: Get.height * this);
  SizedBox get pw => SizedBox(
        width: Get.width * this,
      );
}
