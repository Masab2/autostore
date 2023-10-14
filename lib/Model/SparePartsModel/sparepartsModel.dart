class SparePartsModel {
  String image;
  String title;
  String category;
  String price;
  String description;
  String? quantity;
  String productId;
  bool isFav;

  SparePartsModel(
      {required this.image,
      required this.title,
      required this.category,
      required this.productId,
      this.quantity,
      required this.price,
      required this.description,
      this.isFav = false});
}
