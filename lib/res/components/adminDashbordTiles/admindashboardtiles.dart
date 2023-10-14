// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utility/Colors/AppColor.dart';

class AdminDashBoardtiles extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback ontap;
  Stream stream;
  AdminDashBoardtiles(
      {super.key,
      required this.icon,
      required this.title,
      required this.stream,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: Get.height * 0.20,
          width: Get.width / 2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.geryColor.withOpacity(0.13),
            boxShadow: const [
              BoxShadow(
                color: AppColor.whiteColor,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                0.06.ph,
                StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitChasingDots(
                            color: AppColor.redColor,
                            duration: Duration(seconds: 5),
                            size: 40,
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        return const Text('No Pending orders');
                      } else {
                        final int itemcount = snapshot.data!.docs.length;
                        return itemcount > 0
                            ? Text(itemcount.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    textStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.redColor))
                            : Icon(
                                icon,
                                size: 40,
                                color: AppColor.redColor,
                              );
                      }
                    }),
                0.03.ph,
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      textStyle:
                          const TextStyle(overflow: TextOverflow.ellipsis),
                      fontWeight: FontWeight.bold,
                      color: AppColor.redColor),
                )
              ],
            ),
          )),
    );
  }
}
