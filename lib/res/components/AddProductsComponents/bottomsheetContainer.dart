// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class BottomSheetContainer extends StatelessWidget {
  VoidCallback ongallery;
  VoidCallback oncamera;
  BottomSheetContainer(
      {super.key, required this.ongallery, required this.oncamera});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          0.04.ph,
          Text(
            'Choose Image',
            style: GoogleFonts.roboto(fontSize: 18, color: AppColor.redColor),
          ),
          0.03.ph,
          ListTile(
            title: const Text('Pick Image From Gallery'),
            leading: const Icon(
              Icons.browse_gallery,
              color: AppColor.redColor,
            ),
            onTap: ongallery,
          ),
          ListTile(
            title: const Text('Pick Image From Camera'),
            leading: const Icon(
              Icons.camera,
              color: AppColor.redColor,
            ),
            onTap: oncamera,
          ),
          0.03.ph,
        ],
      ),
    );
  }
}
