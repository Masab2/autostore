import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../../../ViewModel/Admin/Add Amdin/addadmin.dart';
import '../../../res/components/BackRow/backRow.dart';
import '../../../res/components/TextFromFeilds/CustomaizedField.dart';
import '../../../res/components/adminDashbordTiles/createAdminBtn.dart';
import '../../../res/routes/routes_names.dart';

class Removeadmin extends StatefulWidget {
  const Removeadmin({super.key});

  @override
  State<Removeadmin> createState() => _RemoveadminState();
}

class _RemoveadminState extends State<Removeadmin> {
  final emailcontroller = TextEditingController();
  final adminemailcontroller = TextEditingController();
  final adminpasscontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final docController = TextEditingController();
  final addadmin = Get.put(AddAdminViewModel());

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    docController.dispose();
    addadmin.dispose();
    adminemailcontroller.dispose();
    adminpasscontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        leading: BackGroundRow(
          page: RoutesNames.admindashboardScreen,
        ),
        title: Text('All Admins',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.redColor,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.05.ph,
          StreamBuilder(
            stream: Apis.getAllAdmins(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.redColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Not Published Parts here'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                                vertical: Get.height * 0.01),
                            child: Row(
                              children: [
                                0.03.pw,
                                const CircleAvatar(
                                  radius: 35,
                                  backgroundColor: AppColor.redColor,
                                  child: Icon(
                                    Icons.admin_panel_settings_sharp,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                0.03.pw,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['email'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data['password'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: AppColor.geryColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Document Id : ${data['doc']}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: AppColor.geryColor,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                minWidth: Get.width * 0.30,
                                color: AppColor.redColor,
                                onPressed: () {
                                  Apis.deleteAdmin(data['doc']);
                                },
                                child: Text(
                                  'Remove Admin',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              0.13.pw
                            ],
                          ),
                          const Divider(
                            thickness: 1.0,
                            color: AppColor.geryColor,
                            endIndent: 20,
                            indent: 20,
                          )
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              backgroundColor: AppColor.whiteColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
              title: 'Create Admin',
              titlePadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03, vertical: Get.height * 0.03),
              titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: AppColor.redColor),
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                child: Column(
                  children: [
                    CustomizedFeild(title: 'Doc Id', controller: docController),
                    CustomizedFeild(
                        title: 'Email Address', controller: emailcontroller),
                    CustomizedFeild(
                        title: 'Password', controller: passwordcontroller),
                    0.01.ph,
                  ],
                ),
              ),
              actions: [
                CreateAdminBtn(
                  ontap: () {
                    addadmin.createNewAdmin(
                        docController, emailcontroller, passwordcontroller);
                  },
                  title: 'Create Admin',
                )
              ]);
        },
        backgroundColor: AppColor.redColor,
        child: const Icon(
          FontAwesomeIcons.add,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
