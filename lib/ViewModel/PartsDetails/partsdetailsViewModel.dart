import 'package:autostore/Services/firebasehelper.dart';
import 'package:get/get.dart';

class PartDetailsViewModel extends GetxController {
  RxInt quantity = 0.obs;
  RxInt totalprice = 0.obs;

  increaseQuantity(totalquantity, price) {
    if (quantity.value < totalquantity) {
      quantity.value++;
      calculateTotalPrice(price);
    } else {
      Get.snackbar(
          'Quantity OverFlow', 'Maximum Quantity Reached for this product');
    }
  }

  decreaseQuantity(price) {
    if (quantity.value > 0) {
      quantity.value--;
      calculateTotalPrice(price);
    } else {
      quantity.value = 0;
    }
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantity.value;
  }

  void addToCart(var title, category, price, actualquan, detail, imageUrl,
      productid, quan, totalprice, token) {
    if (actualquan < 1) {
      Get.snackbar('0 Quantity', 'Please Select the Qantity');
    } else {
      Apis.addToCart(title, category, price, actualquan.toString(), detail,
              imageUrl, productid, quan, totalprice, token)
          .then((value) {
        Get.snackbar('$title', 'Added to Cart Sucsessfully');
      }).onError((error, stackTrace) {
        Get.snackbar('Erro', 'Added to Cart Sucsessfully');
      });
    }
  }
}
