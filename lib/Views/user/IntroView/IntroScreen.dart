import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/assets/ImageAsset.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: const Image(
                image: AssetImage(
                  ImageAsset.splashbackground,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Text(
                  'Get the Thousands of Parts That Fits Best For you',
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 15,
          child: MaterialButton(
            color: AppColor.redColor,
            minWidth: Get.width * 0.80,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            height: Get.height * 0.07,
            onPressed: () {
              Get.toNamed(RoutesNames.bottomScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Exploring',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
                0.08.pw,
                const Icon(
                  FontAwesomeIcons.arrowRight,
                  color: AppColor.whiteColor,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
