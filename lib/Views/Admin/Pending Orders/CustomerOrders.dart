import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/Utility/assets/ImageAsset.dart';
import 'package:autostore/res/components/AdminOrdersProcessing/AdminOrdersPendings.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../Services/firebasehelper.dart';
import '../../../Utility/Colors/AppColor.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({super.key});

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Customer Orders'),
      body: Column(
        children: [
          StreamBuilder(
              stream: Apis.getAllOrdersforAdmin(),
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
                  return const Text('No Pending orders');
                } else {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.docs[index];
                      Map<String, dynamic>? productsMap = order['products'];
                      List<dynamic> products = productsMap!.values.toList();
                      return AdminOrdersDetails(
                        customername: order['fullname'],
                        image: ImageAsset.applogo,
                        price: order['totalPrice'],
                        time: Utils.convertDate(
                          order['orderDate'],
                        ),
                        customerId: order['customerId'],
                        address: order['address'],
                        ontap: () {
                          Get.toNamed(RoutesNames.pendingOrdersScreen,
                              arguments: {
                                'products': products,
                                'name': order['fullname'],
                                'city': order['city'],
                                'address': order['address'],
                                'customerid': order['customerId'],
                                'orderId': order['orderId'],
                                'token': order['customerToken']
                              });
                        },
                      );
                    },
                  ));
                }
              })
        ],
      ),
    );
  }
}
