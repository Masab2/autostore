import 'package:autostore/Model/CartModel/CartproductModel.dart';
import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/res/components/cart%20componnet/cartContainer.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slideable/slideable.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../../../ViewModel/Cart/cartViewModel.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final controller = Get.put(CartViewModel());
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Shopping Cart'),
      body: StreamBuilder(
        stream: Apis.getCartProduct(),
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
            return const Text('No Product Available');
          } else {
            List<CartProductModel> cartProducts = [];
            for (var element in snapshot.data!.docs) {
              final cartProduct = CartProductModel(
                title: element['title'],
                price: element['price'],
                totalprice: element['totalPrice'],
                image: element['productImages'],
                cartId: element['cartid'],
                category: element['category'],
                actualquantity: element['actualquantity'],
                detail: element['details'],
                quantity: element['quantity'],
                customerid: element['customerid'],
                productid: element['productId'],
              );
              cartProducts.add(cartProduct);
            }
            var data = snapshot.data!.docs;
            controller.updateTotal(data);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Slideable(
                          items: <ActionItems>[
                            ActionItems(
                              icon: const Icon(
                                Icons.delete,
                                color: AppColor.redColor,
                              ),
                              onPress: () {
                                Apis.deleteFromCart(
                                    snapshot.data!.docs[index]['cartid']);
                              },
                              backgroudColor: Colors.transparent,
                            ),
                          ],
                          child: CartContainer(
                            title: snapshot.data!.docs[index]['title'],
                            price: snapshot.data!.docs[index]['totalPrice'],
                            image: snapshot.data!.docs[index]['productImages'],
                            quantity: snapshot.data!.docs[index]
                                ['actualquantity'],
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.02,
                      horizontal: Get.width * 0.02),
                  child: MaterialButton(
                      color: AppColor.redColor,
                      height: Get.height * 0.08,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Get.toNamed(RoutesNames.detailsScreen, arguments: [
                          cartProducts,
                          controller.totalCartPrice.toString(),
                          snapshot.data!.docs.first['customerToken']
                        ]);
                      },
                      child: Obx(() => Text(
                          'Check Out - Total: Rs ${controller.totalCartPrice.value.toString()}',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor)))),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
