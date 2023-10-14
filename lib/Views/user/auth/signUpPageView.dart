import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/Authentication/signUpViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../../../Utility/assets/ImageAsset.dart';
import '../../../res/components/TextFromFeilds/CustomaizedField.dart';
import '../../../res/routes/routes_names.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({super.key});

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final signUpController = Get.put(SignUpViewModel());
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(ImageAsset.applogo)),
            ],
          ),
          0.02.ph,
          Text(
            "Create Your Account",
            style: GoogleFonts.roboto(
                color: AppColor.redColor,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          0.02.ph,
          Text(
            "Revolutionizing Your Ride, One Part at a Time",
            style: GoogleFonts.roboto(
                color: AppColor.redColor.withOpacity(0.44),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          0.03.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Column(
              children: [
                CustomizedFeild(
                  title: 'UserName',
                  prefixIcon: const Icon(Icons.person),
                  controller: usernamecontroller,
                ),
                0.02.ph,
                CustomizedFeild(
                  title: 'Email',
                  hint: 'abc@gmail.com',
                  prefixIcon: const Icon(Icons.email),
                  controller: emailcontroller,
                ),
                0.02.ph,
                ValueListenableBuilder(
                  valueListenable: _obscurepass,
                  builder: (context, value, child) {
                    return CustomizedFeild(
                      title: 'Password',
                      hint: '6 character/digit',
                      prefixIcon: const Icon(Icons.lock),
                      obscuretext: _obscurepass.value,
                      sufixIcon: InkWell(
                          onTap: () {
                            _obscurepass.value = !_obscurepass.value;
                          },
                          child: _obscurepass.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      controller: passwordcontroller,
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  height: Get.height * 0.06,
                  minWidth: Get.width * 0.80,
                  color: AppColor.redColor,
                  onPressed: () {
                    signUpController.signUpAccount(emailcontroller,
                        passwordcontroller, usernamecontroller);
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                0.02.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account",
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: AppColor.geryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    0.01.pw,
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutesNames.loginScreen);
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: AppColor.redColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
