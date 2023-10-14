import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/Utility/Colors/AppColor.dart';
import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:autostore/res/components/HomeComponents/HomeAppBar.dart';
import 'package:autostore/res/components/HomeComponents/partsComponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(() {
        
      }),
      body: Column(
        children: [
          0.02.ph,
          Row(
            children: [
              0.03.pw,
              Text(
                'WishList',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.redColor),
              ),
            ],
          ),
          StreamBuilder(
            stream: Apis.getWishListProduct(),
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
                return const Text('No Product');
              } else {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return PartsComponet(
                          title: data['title'],
                          image: data['productImages'],
                          but1: 'Remove From WishList',
                          but2: 'Buy Now',
                          price: data['price'],
                          ontap: () {},
                          oncart: () {},
                          onwishList: () {
                            Apis.deleteFromWishList(data['wishListid']);
                          },
                          cat: data['category']);
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
