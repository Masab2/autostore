// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utility/Colors/AppColor.dart';


class SparePartsSpecs extends StatelessWidget {
  String cat, detail;
  SparePartsSpecs({super.key, required this.cat, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.geryColor,
            child: Icon(FontAwesomeIcons.automobile),
          ),
          title: Text("Category",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: AppColor.redColor,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(cat,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColor.geryColor,
                  fontWeight: FontWeight.bold)),
        ),
        0.02.ph,
        ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.geryColor,
            child: Icon(FontAwesomeIcons.automobile),
          ),
          title: Text("Description",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: AppColor.redColor,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(detail,
              maxLines: 4,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColor.geryColor,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
