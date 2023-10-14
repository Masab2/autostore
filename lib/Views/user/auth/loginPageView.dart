import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/assets/ImageAsset.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/TextFromFeilds/CustomaizedField.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/Authentication/loginViewModel.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  final loginController = Get.put(LoginViewModel());
  @override
  void dispose() {
    //implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _obscurepass.dispose();
    loginController.dispose();
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
            "Let's Sign you in",
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
          0.06.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Column(
              children: [
                CustomizedFeild(
                  title: 'Email',
                  hint: 'abc@gmail.com',
                  prefixIcon: const Icon(Icons.email),
                  controller: emailcontroller,
                ),
                0.03.ph,
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
                    loginController.loginAccount(
                        emailcontroller, passwordcontroller);
                  },
                  child: Text(
                    'Sign In',
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
                      "Dont't have an account",
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: AppColor.geryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    0.01.pw,
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutesNames.signUpScreen);
                      },
                      child: Text(
                        "Sign Up",
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
