import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/ViewModel/Admin/Notification/notificationViewModel.dart';
import 'package:autostore/res/components/AdminOrdersProcessing/AdminOrderInProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../Utility/Colors/AppColor.dart';

class OrderInProgress extends StatefulWidget {
  const OrderInProgress({super.key});

  @override
  State<OrderInProgress> createState() => _OrderInProgressState();
}

class _OrderInProgressState extends State<OrderInProgress> {
  final sendNotification = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Order InProgress'),
      body: Column(
        children: [
          StreamBuilder(
              stream: Apis.getAllOrdersInProgressforAdmin(),
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
                        var order = snapshot.data!.docs[index];
                        return OrderInProgressComponents(
                          title: order['title'],
                          image: order['productImages'],
                          onRedBtn: () {
                            var newquan = int.parse(order['actualquan']) -
                                int.parse(order['quantity']);
                            Apis.orderDelivered(
                                    order['productId'],
                                    order['title'],
                                    order['category'],
                                    order['price'],
                                    order['details'],
                                    order['productImages'],
                                    order['quantity'],
                                    order['CustomerName'],
                                    order['address'],
                                    order['city'],
                                    order['CustomerId'],
                                    order['token'])
                                .then((value) {
                              Apis.updatePublishedProductQuantity(
                                  order['productId'], newquan.toString());
                              Apis.deleteInProgressProduct(
                                  order['orderInprogressid']);
                              sendNotification.sendNotification(
                                  'Auto Store',
                                  '${order['CustomerName']} your Order ${order['title']} is Deleverd to You',
                                  order['token']);
                              Apis.deleteCustomerOrderAfterDelevered(
                                  order['orderId'], order['cartby']);
                              Apis.totalEarnings(
                                order['productId'],
                                order['title'],
                                order['quantity'],
                                order['price'],
                                order['productImages'],
                                order['CustomerId'],
                              );
                            }).onError((error, stackTrace) {
                              Get.snackbar('Error Occured', error.toString());
                            });
                          },
                          quan: order['quantity'],
                          price: order['price'],
                          redBtntext: 'Sent',
                          address: order['address'],
                          customerId: order['CustomerId'],
                          status: order['Status'],
                          city: order['city'],
                        );
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
