import 'dart:developer';

import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/ViewModel/Admin/Notification/notificationViewModel.dart';
import 'package:autostore/res/components/Published%20Parts%20Componentes/publishedproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  final sendNotification = Get.put(NotificationViewModel());

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    sendNotification.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments;
    final List<dynamic> products = arguments?['products'] ?? [];
    log(arguments!['name']);
    return Scaffold(
      appBar: Utils.appBar('Pending Orders'),
      body: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return PublishedPartsComponent(
            title: products[index]['name'],
            image: products[index]['image'],
            onGreyBtn: () {},
            onRedBtn: () {
              Apis.orderInProgress(
                      products[index]['productId'],
                      products[index]['name'],
                      products[index]['category'],
                      products[index]['ProductTotalPrice'],
                      products[index]['detail'],
                      products[index]['image'],
                      products[index]['actualQuantity'],
                      arguments['name'],
                      arguments['address'],
                      arguments['city'],
                      arguments['customerid'],
                      arguments['token'],
                      products[index]['quantity'],
                      products[index]['cartby'],
                      arguments['orderId'])
                  .then((value) {
                Apis.deleteProductPending(
                    arguments['orderId'], products[index]['cartby']);
                Apis.updateProductStatus(arguments['orderId'],
                    products[index]['cartby'], 'In Progress');
                sendNotification.sendNotification(
                    'Auto Store',
                    '${arguments['name']} your Order ${products[index]['name']} is in Progress',
                    arguments['token']);
              }).onError((error, stackTrace) {
                Get.snackbar('Error', error.toString());
              });
            },
            quan: products[index]['actualQuantity'],
            price: products[index]["ProductTotalPrice"],
            cat: products[index]['category'],
            greyBtnText: 'Cancel',
            redBtntext: 'Accept',
          );
        },
      ),
    );
  }
}
