import 'package:get/get.dart';

class CartViewModel extends GetxController {
  var totalCartPrice = 0.0.obs; // Use Rx to make it reactive

  updateTotal(data) {
    totalCartPrice.value = 0.0;
    for (var i = 0; i < data.length; i++) {
      totalCartPrice.value =
          totalCartPrice.value + int.parse(data[i]['totalPrice'].toString());
    }
  }
}
