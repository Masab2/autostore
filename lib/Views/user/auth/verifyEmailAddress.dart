import 'dart:async';

import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/assets/ImageAsset.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer timer;
  @override
  void initState() {
    Apis.user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImageAsset.verifyemail)),
          0.02.ph,
          RichText(
            text: TextSpan(
              text: 'Verification Link is Send to ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: AppColor.geryColor),
              children: [
                TextSpan(
                    text: '${Apis.user.email}',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, color: AppColor.redColor)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await Apis.user.reload();
    if (Apis.user.emailVerified) {
      timer.cancel();
      Get.offAndToNamed(RoutesNames.introScreen);
    }
  }
}
