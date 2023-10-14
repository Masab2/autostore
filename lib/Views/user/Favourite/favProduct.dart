import 'package:autostore/Utility/extenshions/extenshion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slideable/slideable.dart';

import '../../../Services/firebasehelper.dart';
import '../../../Utility/Colors/AppColor.dart';
import '../../../res/components/HomeComponents/HomeAppBar.dart';
import '../../../res/components/HomeComponents/partsComponents.dart';


class Favouriteproducts extends StatefulWidget {
  const Favouriteproducts({super.key});

  @override
  State<Favouriteproducts> createState() => _FavouriteproductsState();
}

class _FavouriteproductsState extends State<Favouriteproducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(() {}),
      body: Column(
        children: [
          0.02.ph,
          Row(
            children: [
              0.03.pw,
              Text(
                'Favourite',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.redColor),
              ),
            ],
          ),
          StreamBuilder(
            stream: Apis.getFavProduct(),
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
                      return Slideable(
                        items: [
                          ActionItems(
                            icon: const Icon(
                              Icons.delete,
                              color: AppColor.redColor,
                            ),
                            onPress: () {
                              Apis.deleteFromfav(
                                  snapshot.data!.docs[index]['favid']);
                            },
                            backgroudColor: Colors.transparent,
                          ),
                        ],
                        child: PartsComponet(
                            title: data['title'],
                            image: data['productImages'],
                            but1: 'Share',
                            but2: 'Buy Now',
                            price: data['price'],
                            ontap: () {},
                            oncart: () {},
                            onwishList: () {},
                            cat: data['category']),
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
