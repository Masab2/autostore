import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/res/components/EarningsComponetnts/earningsComponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Utility/Colors/AppColor.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Order Delivered'),
      body: StreamBuilder(
        stream: Apis.getEarnings(),
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
                return EarningComponets(
                  title: order['title'],
                  price: order['TotalEarn'].toString(),
                  image: order['image'],
                  customerId: order['customerId'],
                  quan: order['quantity'].toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
