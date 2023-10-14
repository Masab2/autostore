// ignore_for_file: deprecated_member_use

import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/Admin/Admin%20auth/adminloginViewModel.dart';
import 'package:autostore/res/components/BackRow/backRow.dart';
import 'package:autostore/res/components/adminDashbordTiles/admindashboardtiles.dart';
import 'package:autostore/res/components/adminDashbordTiles/createAdminBtn.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/TextFromFeilds/CustomaizedField.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final adminlogin = Get.put(AdminLoginViewModel());
  final adminemailcontroller = TextEditingController();
  final adminpasscontroller = TextEditingController();
  @override
  void dispose() {
    //implement dispose
    super.dispose();
    adminlogin.dispose();
    adminemailcontroller.dispose();
    adminpasscontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        leading: BackGroundRow(
          page: RoutesNames.bottomScreen,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Admin Dashbord',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColor.redColor,
                )),
            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                0.01.ph,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdminDashBoardtiles(
                        icon: FontAwesomeIcons.person,
                        title: 'User',
                        ontap: () {
                          Get.offAllNamed(RoutesNames.alluserScreen);
                        },
                        stream: Apis.getAllUser(),
                      ),
                      AdminDashBoardtiles(
                        icon: FontAwesomeIcons.store,
                        title: 'Published Product',
                        ontap: () {
                          Get.offAllNamed(RoutesNames.publishedPartsScreen);
                        },
                        stream: Apis.pubishedSpareParts(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdminDashBoardtiles(
                        icon: Icons.pending_actions_outlined,
                        title: 'Pending Orders',
                        ontap: () {
                          Get.toNamed(RoutesNames.customerOrdersScreen);
                        },
                        stream: Apis.getAllOrdersforAdmin(),
                      ),
                      AdminDashBoardtiles(
                        icon: Icons.shopping_bag,
                        title: 'Order In Progress',
                        ontap: () {
                          Get.toNamed(RoutesNames.ordersInProgressScreen);
                        },
                        stream: Apis.getAllOrdersInProgressforAdmin(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdminDashBoardtiles(
                        icon: Icons.monetization_on,
                        title: 'Order Delivered',
                        ontap: () {
                          Get.toNamed(RoutesNames.earningScreen);
                        },
                        stream: Apis.getAllOrdersforAdmin(),
                      ),
                      AdminDashBoardtiles(
                        icon: Icons.remove_circle_outline,
                        title: 'Remove Admin',
                        ontap: () {
                          Get.defaultDialog(
                              backgroundColor: AppColor.whiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                  vertical: Get.height * 0.01),
                              title: 'Login First',
                              titlePadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                  vertical: Get.height * 0.03),
                              titleStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.redColor),
                              content: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                child: Column(
                                  children: [
                                    CustomizedFeild(
                                        title: 'Email Address',
                                        controller: adminemailcontroller),
                                    CustomizedFeild(
                                        title: 'Password',
                                        controller: adminpasscontroller),
                                    0.01.ph,
                                  ],
                                ),
                              ),
                              actions: [
                                CreateAdminBtn(
                                  ontap: () {
                                    adminlogin.adminBossLogin(
                                        adminemailcontroller,
                                        adminpasscontroller);
                                  },
                                  title: 'Login',
                                )
                              ]);
                        },
                        stream: Apis.getAllAdmins(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.redColor,
        onPressed: () {
          Get.toNamed(RoutesNames.sendNotificationScreen);
        },
        child: const Icon(
          Icons.notification_add,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
