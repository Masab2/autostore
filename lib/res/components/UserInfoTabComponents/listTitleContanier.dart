// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class ListTileContainer extends StatelessWidget {
  String title;
  IconData icon;
  IconData trailingicon;
  VoidCallback? ontap;
  ListTileContainer({
    super.key,
    required this.title,
    required this.icon,
    this.ontap,
    required this.trailingicon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(
        radius: 35,
        backgroundColor: AppColor.geryColor.withOpacity(0.23),
        child: Center(
            child: Icon(
          icon,
          size: 20,
          color: AppColor.redColor,
        )),
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        trailingicon,
        color: AppColor.redColor,
      ),
    );
  }
}
