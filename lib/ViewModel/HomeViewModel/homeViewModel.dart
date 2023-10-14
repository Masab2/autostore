import 'package:autostore/Services/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final searchController = TextEditingController().obs;
  final isSearching = false.obs;
  RxList<String> categories = <String>[].obs;

  void setsearching() {
    isSearching.value = !isSearching.value;
  }

  void onchanged(var value) {
    searchController.value = value.text;
  }

  void addToWishList(
      var title, category, price, detail, imageUrl, productid, quan) {
    Apis.addToWishList(
            title, category, price, detail, imageUrl, productid, quan)
        .then((value) {
      Get.snackbar('$title', 'Added To WishList');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }

  // Buy Now
  Future<void> addtoCart(var title, category, price, detail, imageUrl,
      productid, quan, token) async {
    var totalprice = 1 * int.parse(price);
    Apis.addToCart(title, category, price, '1', detail, imageUrl, productid,
            quan, totalprice.toString(), token)
        .then((value) {
      Get.snackbar(title, 'Added To Your Cart');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
