// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:autostore/Utility/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/foundation.dart';

import '../Model/CartModel/CartproductModel.dart';
import '../Model/SparePartsModel/sparepartsModel.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static storage.FirebaseStorage imagestorage =
      storage.FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  // User Authentications
  static Future<void> signUpAccount(var email, password, username) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      final user = auth.currentUser;
      final userDoc = await firestore
          .collection('UserInfo')
          .where('uid', isEqualTo: user!.uid)
          .limit(1)
          .get();
      if (userDoc.docs.isEmpty) {
        // String id = DateTime.now().millisecondsSinceEpoch.toString();
        firestore.collection('UserInfo').doc(user.uid).set({
          'username': username,
          'email': email,
          'uid': user.uid,
        });
      }
    });
  }

  // Update the user Profile with there FCM Token
  static Future<void> updateUserData(token) async {
    firestore
        .collection(userInfoCollection)
        .doc(user.uid)
        .update({'token': token});
  }

  // Fetch the user Information from the database
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserDat() {
    return firestore
        .collection(userInfoCollection)
        .where('uid', isEqualTo: user.uid)
        .snapshots();
  }

  // Login To Dashboard
  static Future<void> loginAccount(var email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // LogOut from DashBoard
  static Future<void> logOutAccount() async {
    await auth.signOut();
  }

  // Add Items in Database
  static Future<void> addProducts(
      File file, var title, category, price, quan, detail) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Products Images/Images$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(sparePartCollection).doc(id).set({
        'productid': id,
        'title': title,
        'category': category,
        'price': price,
        'quantity': quan,
        'details': detail,
        'productImages': imageUrl.toString(),
      });
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // Published Spare Parts
  static Stream<QuerySnapshot<Map<String, dynamic>>> pubishedSpareParts() {
    return firestore.collection(sparePartCollection).snapshots();
  }

  // Delete The Spare Parts From Published Parts
  static Future<void> deletePublishedProduct(id) async {
    firestore.collection(sparePartCollection).doc(id).delete();
  }

  // Update The Data of the Published Parts
  static Future<void> updateDataPublishedParts(newQuantity, id) async {
    firestore
        .collection(sparePartCollection)
        .doc(id)
        .update({'quantity': newQuantity.toString()});
  }

  // Get All the User In the Store
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore.collection(userInfoCollection).snapshots();
  }

  // create Admin
  static Future<void> createNewAdmin(var doc, email, password) async {
    await firestore
        .collection(adminCollection)
        .doc(doc)
        .set({'email': email, 'password': password, 'doc': doc}).onError(
            (error, stackTrace) {
      throw FirebaseException;
    });
  }

  // All Admin details
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAdmins() {
    return firestore
        .collection(adminCollection)
        .where('email', isNotEqualTo: 'masabhaider4@gmail.com')
        .snapshots();
  }

  // Delete Admin
  static Future<void> deleteAdmin(var doc) async {
    firestore.collection(adminCollection).doc(doc).delete();
  }

  // Fetched Parts By Specific Category
  static Stream<QuerySnapshot<Map<String, dynamic>>> getProductByCategory(
      String cat) {
    return firestore
        .collection(sparePartCollection)
        .where('category', isEqualTo: cat)
        .snapshots();
  }

  // Add To cart
  static Future<void> addToCart(var title, category, price, actualquan, detail,
      imageUrl, productid, quan, totalprice, token) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.collection(cartCollection).doc(id).set({
      'cartid': id,
      'productId': productid,
      'title': title,
      'category': category,
      'price': price,
      'actualquantity': actualquan,
      'details': detail,
      'customerid': user.uid,
      'productImages': imageUrl.toString(),
      'quantity': quan,
      'totalPrice': totalprice,
      'customerToken': token,
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // Get all Cart Products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartProduct() {
    return firestore
        .collection(cartCollection)
        .where('customerid', isEqualTo: user.uid)
        .snapshots();
  }

  // Remove Form Cart
  static Future<void> deleteFromCart(var id) async {
    firestore.collection(cartCollection).doc(id).delete();
  }

  // Add To WishList
  static Future<void> addToWishList(
      var title, category, price, detail, imageUrl, productid, quan) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.collection(wishListCollection).doc(id).set({
      'wishListid': id,
      'productId': productid,
      'title': title,
      'category': category,
      'price': price,
      'details': detail,
      'customerid': user.uid,
      'productImages': imageUrl.toString(),
      'quantity': quan,
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // Get all WishList Products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getWishListProduct() {
    return firestore
        .collection(wishListCollection)
        .where('customerid', isEqualTo: user.uid)
        .snapshots();
  }

  // Remove From WishList
  static Future<void> deleteFromWishList(var id) async {
    firestore.collection(wishListCollection).doc(id).delete();
  }

  // Add To WishList
  static Future<void> addToFav(SparePartsModel model) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.collection(favCollection).doc(id).set({
      'favid': id,
      'productId': model.productId,
      'title': model.title,
      'category': model.category,
      'price': model.price,
      'details': model.description,
      'customerid': user.uid,
      'productImages': model.image,
      'quantity': model.quantity,
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // Get all fav Products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getFavProduct() {
    return firestore
        .collection(favCollection)
        .where('customerid', isEqualTo: user.uid)
        .snapshots();
  }

  // Remove Form Cart
  static Future<void> deleteFromfav(var id) async {
    firestore.collection(favCollection).doc(id).delete();
  }

  // User Order
  static Future<void> placeUserOrder(List<CartProductModel> products, var name,
      phoneno, city, address, totalprice, orderid, token) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      CollectionReference orders = firestore.collection(orderCollection);
      Map<String, dynamic> orderData = {
        'customerId': user.uid,
        'fullname': name.toString(),
        'mobileno': phoneno.toString(),
        'city': city.toString(),
        'orderDate': DateTime.now().toString(),
        'email': user.email,
        'address': address.toString(),
        'products': {},
        'orderId': orderid,
        'totalPrice': totalprice.toString(),
        'token': token
      };
      for (var product in products) {
        orderData['products'][product.cartId] = {
          'name': product.title,
          'productId': product.productid,
          'image': product.image,
          'price': product.price,
          'quantity': product.quantity,
          'detail': product.detail,
          'cartby': product.cartId,
          'category': product.category,
          'actualQuantity': product.actualquantity,
          'Status': "pending",
          'ProductTotalPrice': product.totalprice
        };
      }
      await orders.doc(orderid).set(orderData);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  //Order of Customer is Deleted After it is Deleverd
  static Future<void> deleteCustomerOrderAfterDelevered(
      String orderId, String productId) async {
    try {
      CollectionReference orders = firestore.collection(orderCollection);
      DocumentSnapshot orderSnapshot = await orders.doc(orderId).get();
      if (orderSnapshot.exists) {
        Map<String, dynamic> orderData =
            orderSnapshot.data() as Map<String, dynamic>;
        if (orderData['products'] != null &&
            orderData['products'][productId] != null) {
          orderData['products'].remove(productId);
          if (orderData['products'].isEmpty) {
            await orders.doc(orderId).delete();
            debugPrint('Entire order removed since all products were removed.');
          } else {
            await orders
                .doc(orderId)
                .update({'products': orderData['products']});
            debugPrint('Product removed from order successfully.');
          }
          debugPrint('Product removed from order successfully.');
        } else {
          debugPrint('Product not found in the order.');
        }
      } else {
        debugPrint('Order not found.');
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  // For Admin
  static Future<void> placeUserOrderforAdmin(List<CartProductModel> products,
      var name, phoneno, city, address, totalprice, orderid, token) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      CollectionReference orders = firestore.collection(orderAdminCollection);
      Map<String, dynamic> orderData = {
        'customerId': user.uid,
        'fullname': name.toString(),
        'mobileno': phoneno.toString(),
        'city': city.toString(),
        'orderDate': DateTime.now().toString(),
        'email': user.email,
        'address': address.toString(),
        'products': {},
        'orderId': orderid,
        'totalPrice': totalprice.toString(),
        'customerToken': token
      };
      for (var product in products) {
        orderData['products'][product.cartId] = {
          'name': product.title,
          'productId': product.productid,
          'image': product.image,
          'price': product.price,
          'quantity': product.quantity,
          'detail': product.detail,
          'cartby': product.cartId,
          'category': product.category,
          'actualQuantity': product.actualquantity,
          'Status': "pending",
          'ProductTotalPrice': product.totalprice
        };
      }
      await orders.doc(orderid).set(orderData);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  static Future<void> deleteAllDocumentsInCollectionAddtoCart() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(cartCollection);
    QuerySnapshot querySnapshot = await collectionRef.get();
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }

  // Get Order details Of Repected user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrdersOfCustomer() {
    return firestore
        .collection(orderCollection)
        .where('customerId', isEqualTo: user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrdersforAdmin() {
    return firestore.collection(orderAdminCollection).snapshots();
  }

  // Order in Progress
  static Future<void> orderInProgress(
      productid,
      title,
      cat,
      price,
      description,
      image,
      quan,
      name,
      address,
      city,
      customerid,
      token,
      actualquan,
      cartBy,
      orderId) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.collection(orderInProgressCollection).doc(id).set({
      'orderInprogressid': id,
      'productId': productid,
      'title': title,
      'category': cat,
      'price': price,
      'details': description,
      'productImages': image,
      'quantity': quan,
      'actualquan': actualquan,
      'CustomerName': name,
      'address': address,
      'city': city,
      'CustomerId': customerid,
      'Status': "inProgress",
      'token': token,
      'cartby': cartBy,
      'orderId': orderId
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // getOrderInprogress
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllOrdersInProgressforAdmin() {
    return firestore.collection(orderInProgressCollection).snapshots();
  }

  // Update The Status In the User Side of the Product
  static Future<void> updateProductStatus(
      String orderId, String productId, String newStatus) async {
    try {
      CollectionReference orders = firestore.collection(orderCollection);
      DocumentSnapshot orderSnapshot = await orders.doc(orderId).get();
      if (orderSnapshot.exists) {
        Map<String, dynamic> orderData =
            orderSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> productsMap =
            orderData['products'] as Map<String, dynamic>;
        if (productsMap.containsKey(productId)) {
          productsMap[productId]['Status'] = newStatus;
          await orders.doc(orderId).update({'products': productsMap});
        } else {
          if (kDebugMode) {
            print('Product ID not found in the order: $productId');
          }
        }
      } else {
        if (kDebugMode) {
          print('Order ID not found: $orderId');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  //Delete the product From Pending
  static Future<void> deleteProductPending(
      String orderId, String productId) async {
    try {
      CollectionReference orders = firestore.collection(orderAdminCollection);
      DocumentSnapshot orderSnapshot = await orders.doc(orderId).get();
      if (orderSnapshot.exists) {
        Map<String, dynamic> orderData =
            orderSnapshot.data() as Map<String, dynamic>;
        if (orderData['products'] != null &&
            orderData['products'][productId] != null) {
          orderData['products'].remove(productId);
          if (orderData['products'].isEmpty) {
            await orders.doc(orderId).delete();
            debugPrint('Entire order removed since all products were removed.');
          } else {
            await orders
                .doc(orderId)
                .update({'products': orderData['products']});
            debugPrint('Product removed from order successfully.');
          }
          debugPrint('Product removed from order successfully.');
        } else {
          debugPrint('Product not found in the order.');
        }
      } else {
        debugPrint('Order not found.');
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  // OrderDelivered
  static Future<void> orderDelivered(productid, title, cat, price, description,
      image, quan, name, address, city, customerid, token) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firestore.collection(orderDeleveredCollection).doc(id).set({
      'orderdeleveredid': id,
      'productId': productid,
      'title': title,
      'category': cat,
      'price': price,
      'details': description,
      'productImages': image,
      'quantity': quan,
      'CustomerName': name,
      'address': address,
      'city': city,
      'CustomerId': customerid,
      'Status': "Delivered",
      'token': token,
      'OrderDate': DateTime.now().toString()
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // get Order Delivered To the Customer
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllOrderDeliveredOfCustomer() {
    return firestore
        .collection(orderDeleveredCollection)
        .where('CustomerId', isEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updatePublishedProductQuantity(
      productid, newquantity) async {
    firestore
        .collection(sparePartCollection)
        .doc(productid)
        .update({'quantity': newquantity});
  }

  static Future<void> deleteInProgressProduct(orderid) async {
    firestore.collection(orderInProgressCollection).doc(orderid).delete();
  }

  //Total Earnings
  static Future<void> totalEarnings(
      productId, title, quantity, earn, image, customerId) async {
    final CollectionReference earningsCollection =
        FirebaseFirestore.instance.collection(earningCollection);
    final DocumentSnapshot existingDoc =
        await earningsCollection.doc(productId).get();
    if (existingDoc.exists) {
      if (existingDoc['customerId'] == customerId) {
        await earningsCollection.doc(productId).update({
          'quantity': FieldValue.increment(int.parse(quantity)),
          'TotalEarn': FieldValue.increment(int.parse(earn))
        });
      }
    } else {
      await earningsCollection.doc(productId).set({
        'productId': productId,
        'title': title,
        'quantity': quantity,
        'TotalEarn': earn,
        'image': image,
        'customerId': customerId
      });
    }
  }

  // Get Total Earnings
  static Stream<QuerySnapshot<Map<String, dynamic>>> getEarnings() {
    return firestore.collection(earningCollection).snapshots();
  }
}
