// ignore_for_file: must_be_immutable

import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoDetails extends StatelessWidget {
  String title;
  IconData icon;
  IconData trailingicon;
  VoidCallback? ontap;
  Stream stream;
  UserInfoDetails(
      {super.key,
      required this.title,
      required this.icon,
      required this.trailingicon,
      required this.stream,
      this.ontap});

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
        trailing: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                int itemCount = snapshot.data?.docs.length ?? 0;
                return itemCount == 0
                    ? Icon(
                        trailingicon,
                        color: AppColor.redColor,
                      )
                    : Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            color: AppColor.redColor,
                            borderRadius: BorderRadius.circular(20)),
                      );
              }
            }));
  }
}
