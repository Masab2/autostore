// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityContainer extends StatelessWidget {
  final String title;
  VoidCallback onplus;
  VoidCallback onMinus;
  QuantityContainer(
      {super.key,
      required this.title,
      required this.onplus,
      required this.onMinus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onMinus,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: AppColor.ligthgreyColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text('-',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ),
        0.01.pw,
        Text(title),
        0.01.pw,
        InkWell(
          onTap: onplus,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: AppColor.ligthgreyColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              '+',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
