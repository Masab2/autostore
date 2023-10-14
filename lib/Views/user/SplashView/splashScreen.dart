import 'package:autostore/Utility/assets/ImageAsset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/SplashViewModel/splashViewModel.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _services = SplashServices();
  @override
  void initState() {
    //implement initState
    super.initState();
    _services.moveToIntro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Image(image: AssetImage(ImageAsset.applogo))),
          Text(
            'Auto Store',
            style:
                GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
