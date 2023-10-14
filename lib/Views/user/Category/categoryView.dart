import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/ViewModel/HomeViewModel/homeViewModel.dart';
import 'package:autostore/res/components/categoryComponents/categoryPartsDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../../../Utility/Utils/Utils.dart';
import '../../../ViewModel/Category/categoryViewModel.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final categoryController = Get.put(CategoryViewModel());
  final homecontroller = Get.find<HomeViewModel>();
  final token = Get.arguments;
  @override
  void dispose() {
    categoryController.dispose();
    homecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Parts Category'),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.06,
            child: ListView.builder(
              itemCount: categoryController.categoryList.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(
                        right: Get.width * 0.02, left: Get.width * 0.02),
                    child: Obx(() {
                      return InkWell(
                        onTap: () {
                          categoryController.setCategory(
                              categoryController.categoryList[index]);
                        },
                        child: Container(
                          height: Get.height * 0.08,
                          width: Get.width * 0.28,
                          decoration: BoxDecoration(
                              // ignore: unrelated_type_equality_checks
                              color: categoryController.categoryname ==
                                      categoryController.categoryList[index]
                                  ? AppColor.redColor
                                  : AppColor.geryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              categoryController.categoryList[index],
                              style: GoogleFonts.poppins(
                                  color: AppColor.whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    }));
              },
            ),
          ),
          0.02.ph,
          Obx(() {
            return StreamBuilder(
              stream: Apis.getProductByCategory(
                  categoryController.categoryname.value),
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
                    itemCount: snapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return CategoryPartsComponet(
                        title: data['title'],
                        image: data['productImages'],
                        btntitle: 'Buy Now',
                        price: data['price'],
                        cat: data['category'],
                        ontap: () {
                          homecontroller.addtoCart(
                              data['title'],
                              data['category'],
                              data['price'],
                              data['details'],
                              data['productImages'],
                              data['productid'],
                              data['quantity'],
                              token);
                        },
                      );
                    },
                  ));
                }
              },
            );
          })
        ],
      ),
    );
  }
}
