import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  RxList<String> categoryList = [
    'Rims',
    'tyre',
    'oil',
    'engine',
  ].obs;
  var categoryname = 'Rims'.obs;

  setCategory(value) {
    categoryname.value = value;
  }
}
