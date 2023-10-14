import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/Utils/Utils.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/TextFromFeilds/CustomaizedField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ViewModel/Admin/Notification/notificationViewModel.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final titlecontroller = TextEditingController();
  final bodycontroller = TextEditingController();
  final notificationController = Get.put(NotificationViewModel());

  @override
  void dispose() {
    //implement dispose
    super.dispose();
    titlecontroller.dispose();
    bodycontroller.dispose();
    notificationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar('Send Notification'),
      body: Column(
        children: [
          0.03.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              children: [
                CustomizedFeild(
                  hint: 'Title',
                  controller: titlecontroller,
                  title: 'Title',
                ),
                0.02.ph,
                CustomizedFeild(
                  hint: 'Enter Details',
                  controller: bodycontroller,
                  title: 'Body',
                  maxlines: 5,
                ),
              ],
            ),
          ),
          0.03.ph,
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: AppColor.redColor,
            height: Get.height * 0.06,
            child: Text('Send Notification',
                style: GoogleFonts.poppins(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            onPressed: () {
              notificationController.sendNotificationToAll(
                  titlecontroller, bodycontroller);
            },
          )
        ],
      ),
    );
  }
}
