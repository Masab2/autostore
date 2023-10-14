import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/BackRow/backRow.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utility/Colors/AppColor.dart';

class AllUserData extends StatefulWidget {
  const AllUserData({super.key});

  @override
  State<AllUserData> createState() => _AllUserDataState();
}

class _AllUserDataState extends State<AllUserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        leading: BackGroundRow(
          page: RoutesNames.admindashboardScreen,
        ),
        title: Text('All Login User',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.redColor,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.05.ph,
          StreamBuilder(
            stream: Apis.getAllUser(),
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
                return const Center(child: Text('Not Published Parts here'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.03,
                            vertical: Get.height * 0.01),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor:
                                  AppColor.redColor.withOpacity(0.23),
                              radius: 25,
                              child: const Icon(Icons.person)),
                          title: Text(snapshot.data!.docs[index]['username']
                              .toString()),
                          subtitle: Text(
                              snapshot.data!.docs[index]['email'].toString()),
                        ),
                      );
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
