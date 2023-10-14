import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/res/components/MyOrderComponents/myOrderComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Utility/Colors/AppColor.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('My Order'),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getAllOrdersOfCustomer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.redColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Product Available');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.docs[index];
                      Map<String, dynamic>? productsMap = order['products'];
                      if (productsMap == null || productsMap.isEmpty) {
                        return const SizedBox();
                      } else {
                        List<dynamic> products = productsMap.values.toList();
                        return Column(
                          children: [
                            ListView.builder(
                              itemCount: productsMap.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MyOrderDetails(
                                  title: products[index]['name'],
                                  image: products[index]['image'],
                                  quan: products[index]['actualQuantity'],
                                  price: products[index]["price"],
                                  cat: products[index]['category'],
                                  time: Utils.convertDate(order['orderDate']),
                                  status: products[index]['Status'],
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
