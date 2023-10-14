import 'package:autostore/Model/CartModel/CartproductModel.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/AddProductsComponents/partsdetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/CheckOutControllers/userDetailsViewModel.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final usernameController = TextEditingController();
  final mobilenoController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final controller = Get.put(UserDetailsViewModel());
  @override
  void dispose() {
    //implement dispose
    usernameController.dispose();
    emailController.dispose();
    mobilenoController.dispose();
    cityController.dispose();
    addressController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CartProductModel> cartProducts =
        Get.arguments[0] as List<CartProductModel>;
    final totalprice = Get.arguments[1];
    final token = Get.arguments[2];
    return Scaffold(
        appBar: Utils.appBar('Add Address'),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              0.03.ph,
              PartsDetail(
                  title: 'Full Name',
                  icon: Icons.person,
                  controller: usernameController),
              PartsDetail(
                  title: 'Mobile Number',
                  icon: FontAwesomeIcons.mobileScreen,
                  hint: '0300*******',
                  keyboardtype: TextInputType.phone,
                  controller: mobilenoController),
              PartsDetail(
                  title: 'Email Address',
                  icon: Icons.email_outlined,
                  hint: 'abc@gmail.com',
                  keyboardtype: TextInputType.emailAddress,
                  controller: emailController),
              PartsDetail(
                  title: 'City',
                  icon: Icons.edit_location_alt_rounded,
                  hint: 'e.g Lahore',
                  controller: cityController),
              PartsDetail(
                  title: 'Address',
                  icon: FontAwesomeIcons.addressCard,
                  keyboardtype: TextInputType.streetAddress,
                  hint: 'House No/Building No,Street,Area',
                  controller: addressController),
              0.02.ph,
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
            child: MaterialButton(
              height: Get.height * 0.07,
              color: AppColor.redColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                controller.saveAndContinue(
                  cartProducts,
                  usernameController,
                  mobilenoController,
                  cityController,
                  addressController,
                  totalprice,
                  token,
                  context,
                );
              },
              child: Text(
                'Place Order',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.whiteColor,
                ),
              ),
            )));
  }
}
