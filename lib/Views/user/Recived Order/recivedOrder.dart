import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/res/components/MyOrderComponents/myOrderComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Utility/Colors/AppColor.dart';

class RecivedOrder extends StatefulWidget {
  const RecivedOrder({super.key});

  @override
  State<RecivedOrder> createState() => _RecivedOrderState();
}

class _RecivedOrderState extends State<RecivedOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Order Recived'),
      body: StreamBuilder(
        stream: Apis.getAllOrderDeliveredOfCustomer(),
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final order = snapshot.data!.docs[index];
                return MyOrderDetails(
                    title: order['title'],
                    image: order['productImages'],
                    quan: order['quantity'],
                    price: order['price'],
                    time: Utils.convertDate(order['OrderDate']),
                    status: order['Status'],
                    cat: order['category']);
              },
            );
          }
        },
      ),
    );
  }
}
