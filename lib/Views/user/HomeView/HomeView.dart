// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:autostore/Model/SparePartsModel/sparepartsModel.dart';
import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/HomeViewModel/homeViewModel.dart';
import 'package:autostore/res/components/HomeComponents/SearchBar.dart';
import 'package:autostore/res/components/HomeComponents/partsComponents.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Services/notificationServices.dart';
import '../../../res/components/HomeComponents/HomeAppBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController = TextEditingController();
  final homeController = Get.put(HomeViewModel());
  NotificationServices services = NotificationServices();
  var token;
  @override
  void initState() {
    //implement initState
    services.requestNotificationPermission();
    services.isTokenRefresh();
    services.firebaseinit(context);
    services.getDeviceToken().then((value) {
      token = value.toString();
      log(token.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    services;
    searchController.dispose();
    homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: HomeAppBar.HomeBar(() {
          Get.toNamed(RoutesNames.categoryScreen, arguments: token);
        }),
        body: Column(children: [
          0.03.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Search Parts',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColor.geryColor,
                  )),
            ],
          ),
          0.02.ph,
          HomeSearchBar(
            searchController: searchController,
            ontap: () {
              homeController.onchanged(searchController.text);
            },
          ),
          0.02.ph,
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
                return const Text('No Product For Sale');
              } else {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      String title = data['title'];
                      final sparepart = SparePartsModel(
                          image: data['productImages'],
                          title: title,
                          category: data['category'],
                          price: data['price'],
                          description: data['details'],
                          quantity: data['quantity'],
                          productId: data['productid']);
                      if (searchController.text.isEmpty) {
                        return PartsComponet(
                          title: sparepart.title,
                          image: sparepart.image,
                          price: sparepart.price,
                          cat: sparepart.category,
                          ontap: () {
                            Get.toNamed(RoutesNames.partsDetailScreen,
                                arguments: [sparepart, token]);
                          },
                          oncart: () {
                            homeController
                                .addtoCart(
                                    title,
                                    data['category'],
                                    data['price'],
                                    data['details'],
                                    data['productImages'],
                                    data['productid'],
                                    data['quantity'],
                                    token)
                                .then((value) {
                              Get.toNamed(RoutesNames.cartScreen);
                            });
                          },
                          onwishList: () {
                            homeController.addToWishList(
                                title,
                                sparepart.category,
                                sparepart.price,
                                sparepart.description,
                                sparepart.image,
                                data['productid'],
                                sparepart.quantity);
                          },
                          but1: 'Add To WishList',
                          but2: 'Buy Now',
                        );
                      } else if (title
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return PartsComponet(
                          title: sparepart.title,
                          image: sparepart.image,
                          price: sparepart.price,
                          cat: sparepart.category,
                          ontap: () {
                            Get.toNamed(RoutesNames.partsDetailScreen,
                                arguments: sparepart);
                          },
                          oncart: () {
                            homeController
                                .addtoCart(
                                    title,
                                    data['category'],
                                    data['price'],
                                    data['details'],
                                    data['productImages'],
                                    data['productid'],
                                    data['quantity'],
                                    token.toString())
                                .then((value) {
                              Get.toNamed(RoutesNames.cartScreen);
                            });
                          },
                          onwishList: () {
                            homeController.addToWishList(
                                title,
                                sparepart.category,
                                sparepart.price,
                                sparepart.description,
                                sparepart.image,
                                data['productid'],
                                sparepart.quantity);
                          },
                          but1: 'Add To WishList',
                          but2: 'Buy Now',
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
