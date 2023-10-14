// ignore_for_file: deprecated_member_use

import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/BackRow/backRow.dart';
import 'package:autostore/res/components/Published%20Parts%20Componentes/publishedproduct.dart';
import 'package:autostore/res/components/TextFromFeilds/CustomaizedField.dart';
import 'package:autostore/res/components/adminDashbordTiles/createAdminBtn.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PublishedParts extends StatefulWidget {
  const PublishedParts({super.key});

  @override
  State<PublishedParts> createState() => _PublishedPartsState();
}

class _PublishedPartsState extends State<PublishedParts> {
  final quantityController = TextEditingController();
  @override
  void dispose() {
    //implement dispose
    super.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        leading: BackGroundRow(
          page: RoutesNames.admindashboardScreen,
        ),
        title: Text('Published Parts',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.redColor,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.pubishedSpareParts(),
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
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return PublishedPartsComponent(
                        title: snapshot.data!.docs[index]['title'],
                        image: snapshot.data!.docs[index]["productImages"],
                        onGreyBtn: () {
                          Get.defaultDialog(
                              backgroundColor: AppColor.whiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                  vertical: Get.height * 0.01),
                              title: 'Update Quantity',
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
                                        title: 'Quantity',
                                        hint: '1*******',
                                        controller: quantityController),
                                    0.01.ph,
                                  ],
                                ),
                              ),
                              actions: [
                                CreateAdminBtn(
                                  ontap: () {
                                    Apis.updateDataPublishedParts(
                                        quantityController.text.toString(),
                                        snapshot.data!.docs[index]
                                            ['productid']);
                                    Get.back();
                                  },
                                  title: 'Update',
                                )
                              ]);
                        },
                        onRedBtn: () {
                          Apis.deletePublishedProduct(
                              snapshot.data!.docs[index]['productid']);
                        },
                        quan: snapshot.data!.docs[index]['quantity'],
                        price: snapshot.data!.docs[index]['price'],
                        cat: snapshot.data!.docs[index]['category'],
                        greyBtnText: 'Update',
                        redBtntext: 'Un-Published',
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(RoutesNames.addproductScreen);
        },
        backgroundColor: AppColor.redColor,
        child: const Icon(
          FontAwesomeIcons.shoppingBag,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
