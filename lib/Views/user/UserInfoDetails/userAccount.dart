import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/HomeComponents/HomeAppBar.dart';
import 'package:autostore/res/components/UserInfoTabComponents/listTitleContanier.dart';
import 'package:autostore/res/components/UserInfoTabComponents/userInfoDetails.dart';
import 'package:autostore/res/components/UserInfoTabComponents/usernameContainer.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Services/firebasehelper.dart';
import '../../../ViewModel/Authentication/loginViewModel.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final logOutController = Get.put(LoginViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(() {}),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            0.03.ph,
            StreamBuilder(
                stream: Apis.fetchUserDat(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: AppColor.whiteColor,
                        highlightColor: AppColor.geryColor,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ));
                  } else if (!snapshot.hasData) {
                    return UserInfoContainer(title: 'Null', subtitle: 'Null');
                  } else {
                    return UserInfoContainer(
                        title: snapshot.data!.docs.first['username'],
                        subtitle: snapshot.data!.docs.first['email']);
                  }
                }),
            0.04.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Row(
                      children: [
                        Text(
                          'Personal',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  0.02.ph,
                  UserInfoDetails(
                    ontap: () {
                      Get.toNamed(RoutesNames.myOrderScreen);
                    },
                    title: 'My Orders',
                    icon: FontAwesomeIcons.cartShopping,
                    trailingicon: Icons.arrow_forward_ios,
                    stream: Apis.getAllOrdersOfCustomer(),
                  ),
                  0.02.ph,
                  UserInfoDetails(
                    ontap: () {
                      Get.toNamed(RoutesNames.orderDeleveredScreen);
                    },
                    title: 'Order Recived',
                    icon: FontAwesomeIcons.receipt,
                    trailingicon: Icons.arrow_forward_ios,
                    stream: Apis.getAllOrderDeliveredOfCustomer(),
                  ),
                  0.02.ph,
                  UserInfoDetails(
                    ontap: () {
                      Get.toNamed(RoutesNames.cartScreen);
                    },
                    title: 'My Cart',
                    icon: FontAwesomeIcons.cartShopping,
                    trailingicon: Icons.arrow_forward_ios,
                    stream: Apis.getCartProduct(),
                  ),
                  0.02.ph,
                  ListTileContainer(
                    ontap: () {
                      Get.defaultDialog(
                        title: 'Log Out',
                        middleText: 'Are you Sure you want to cancel',
                        textConfirm: 'Yes',
                        textCancel: 'Cancel',
                        backgroundColor: AppColor.whiteColor,
                        buttonColor: AppColor.redColor,
                        onConfirm: () {
                          logOutController.logOutAccount();
                          Get.back();
                        },
                      );
                    },
                    title: 'LogOut',
                    icon: Icons.logout,
                    trailingicon: Icons.arrow_forward_ios,
                  ),
                  0.02.ph,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Row(
                      children: [
                        Text(
                          'For Admin Only',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  0.02.ph,
                  ListTileContainer(
                    ontap: () {
                      Get.offAllNamed(RoutesNames.adminloginScreen);
                    },
                    title: 'Admin Account',
                    icon: Icons.admin_panel_settings,
                    trailingicon: Icons.arrow_forward_ios,
                  ),
                  0.02.ph,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
