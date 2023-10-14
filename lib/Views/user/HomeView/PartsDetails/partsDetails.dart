// ignore_for_file: deprecated_member_use

import 'package:autostore/Model/SparePartsModel/sparepartsModel.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/Favourite/favouriteViewModel.dart';
import 'package:autostore/Views/user/HomeView/PartsDetails/sparepartsSpecs.dart';
import 'package:autostore/res/components/HomeComponents/PartsDetailsComponents/title.dart';
import 'package:autostore/res/components/cart%20componnet/quantitycontanier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utility/Colors/AppColor.dart';
import '../../../../ViewModel/PartsDetails/partsdetailsViewModel.dart';
import 'navigationRow.dart';

class PartsDetails extends StatefulWidget {
  const PartsDetails({super.key});

  @override
  State<PartsDetails> createState() => _PartsDetailsState();
}

class _PartsDetailsState extends State<PartsDetails> {
  final partscontroller = Get.put(PartDetailsViewModel());
  final favcontroller = Get.put(FavouriteViewModel());
  @override
  void dispose() {
    partscontroller.dispose();
    // favcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spareparts = Get.arguments[0] as SparePartsModel;
    final token = Get.arguments[1];
    final totalquan = int.parse(spareparts.quantity.toString());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            0.03.ph,
            Stack(
              children: [
                CachedNetworkImage(
                  height: Get.height * 0.40,
                  width: Get.width,
                  imageUrl: spareparts.image,
                  placeholder: (context, url) => const SpinKitChasingDots(
                    color: AppColor.redColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: NavigationRow(
                      fav: IconButton(
                          onPressed: () {
                            if (spareparts.isFav) {
                              Get.snackbar(spareparts.title,
                                  'Already in your favourite');
                            } else {
                              favcontroller.addtoFav(spareparts);
                            }
                          },
                          icon: Icon(
                            spareparts.isFav == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColor.redColor,
                            size: 25,
                          )),
                      onback: () {
                        Get.back();
                      },
                    )),
              ],
            ),
            0.03.ph,
            PartsTitle(title: spareparts.title, price: spareparts.price),
            0.02.ph,
            SparePartsSpecs(
                cat: spareparts.category, detail: spareparts.description),
            0.03.ph,
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.redColor),
                          ),
                          QuantityContainer(
                            title: partscontroller.quantity.toString(),
                            onplus: () {
                              partscontroller.increaseQuantity(
                                  totalquan, int.parse(spareparts.price));
                            },
                            onMinus: () {
                              partscontroller.decreaseQuantity(
                                  int.parse(spareparts.price));
                            },
                          ),
                        ],
                      ),
                      0.02.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.redColor)),
                          Text("${partscontroller.totalprice.toString()} RS",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.geryColor)),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
        child: MaterialButton(
          color: AppColor.redColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          height: Get.height * 0.08,
          onPressed: () {
            partscontroller.addToCart(
                spareparts.title,
                spareparts.category,
                spareparts.price,
                partscontroller.quantity.value,
                spareparts.description,
                spareparts.image,
                spareparts.productId,
                spareparts.quantity,
                partscontroller.totalprice.value.toString(),
                token);
          },
          child: Text("Add to Cart",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
