import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/CartModel/CartproductModel.dart';

class UserDetailsViewModel extends GetxController {
  var orderid = DateTime.now().millisecondsSinceEpoch.toString();
  void saveAndContinue(
      List<CartProductModel> products,
      TextEditingController name,
      TextEditingController phoneno,
      TextEditingController city,
      TextEditingController address,
      var totalprice,
      var token,
      BuildContext context) {
    if (name.text.isEmpty &&
        phoneno.text.isEmpty &&
        phoneno.text.isEmpty &&
        city.text.isEmpty &&
        address.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Fill the Feilds');
    } else if (name.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please enter the name');
    } else if (phoneno.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please enter the mobile no');
    } else if (city.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please enter the city');
    } else if (address.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please enter the address');
    } else {
      Apis.placeUserOrderforAdmin(products, name.text, phoneno.text, city.text,
          address.text, totalprice, orderid, token);
      Apis.placeUserOrder(products, name.text, phoneno.text, city.text,
              address.text, totalprice, orderid, token)
          .then((value) {
        Apis.deleteAllDocumentsInCollectionAddtoCart();
        name.clear();
        phoneno.clear();
        city.clear();
        address.clear();
        Utils.DialogBox(context);
      });
    }
  }
}
