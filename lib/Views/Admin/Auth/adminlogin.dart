import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/Admin/Admin%20auth/adminloginViewModel.dart';
import 'package:autostore/res/components/BackRow/backRow.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utility/Colors/AppColor.dart';
import '../../../Utility/assets/ImageAsset.dart';
import '../../../res/components/TextFromFeilds/CustomaizedField.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  final adminlogin = Get.put(AdminLoginViewModel());
  @override
  void dispose() {
    //implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _obscurepass.dispose();
    adminlogin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackGroundRow(page: RoutesNames.bottomScreen),
      ),
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
            "Hey! Login your Account here",
            maxLines: 2,
            style: GoogleFonts.roboto(
                color: AppColor.redColor,
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          0.02.ph,
          Text(
            "Only For Admin",
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
                    adminlogin.adminLogin(emailcontroller, passwordcontroller);
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
              ],
            ),
          )
        ]),
      ),
    );
  }
}
