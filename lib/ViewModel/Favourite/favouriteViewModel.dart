import 'package:autostore/Model/SparePartsModel/sparepartsModel.dart';
import 'package:autostore/Services/firebasehelper.dart';
import 'package:get/get.dart';

class FavouriteViewModel extends GetxController {
  
  
  void addtoFav(SparePartsModel model) {
    Apis.addToFav(model).then((msg) {
      model.isFav = true;
      Get.snackbar(model.title, 'Product Add to favourite');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
