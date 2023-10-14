class CartProductModel {
  String title;
  String cartId;
  String price;
  String totalprice;
  String quantity;
  String category;
  String actualquantity;
  String detail;
  String image;
  String customerid;
  String productid;

  CartProductModel({
    required this.title,
    required this.price,
    required this.totalprice,
    required this.image,
    required this.cartId,
    required this.category,
    required this.actualquantity,
    required this.detail,
    required this.productid,
    required this.quantity,
    required this.customerid,
  });
}
