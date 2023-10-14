import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../Utility/Colors/AppColor.dart';
import '../Favourite/favProduct.dart';
import '../HomeView/HomeView.dart';
import '../UserInfoDetails/userAccount.dart';
import '../WishList/wishListView.dart';

class BottomPageView extends StatefulWidget {
  const BottomPageView({super.key});

  @override
  State<BottomPageView> createState() => _BottomPageViewState();
}

class _BottomPageViewState extends State<BottomPageView> {
  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          color: AppColor.redColor,
        ),
        inactiveIcon: const Icon(
          Icons.home,
          color: AppColor.geryColor,
        ),
        activeColorPrimary: AppColor.ligthgreyColor,
        activeColorSecondary: AppColor.redColor,
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.shoppingBasket,
            color: AppColor.redColor,
          ),
          inactiveIcon: const Icon(
            FontAwesomeIcons.shoppingBasket,
            color: AppColor.geryColor,
          ),
          activeColorPrimary: AppColor.ligthgreyColor,
          activeColorSecondary: AppColor.redColor,
          title: 'WishList',
          textStyle: GoogleFonts.poppins(color: AppColor.redColor)),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.favorite,
            color: AppColor.redColor,
          ),
          inactiveIcon: const Icon(
            Icons.favorite,
            color: AppColor.geryColor,
          ),
          activeColorPrimary: AppColor.ligthgreyColor,
          activeColorSecondary: AppColor.redColor,
          title: 'Favourite',
          textStyle: GoogleFonts.poppins(color: AppColor.redColor)),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.person,
            color: AppColor.redColor,
          ),
          inactiveIcon: const Icon(
            Icons.person,
            color: AppColor.geryColor,
          ),
          activeColorPrimary: AppColor.ligthgreyColor,
          activeColorSecondary: AppColor.redColor,
          title: 'Account',
          textStyle: GoogleFonts.poppins(color: AppColor.redColor)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      padding: NavBarPadding.symmetric(horizontal: Get.width * 0.03),
      screens: const [
        HomeView(),
        WishListView(),
        Favouriteproducts(),
        UserAccount()
      ],
      confineInSafeArea: true,
      stateManagement: true,
      popAllScreensOnTapOfSelectedTab: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      navBarStyle: NavBarStyle.style1,
      items: _navBarItem(),
    );
  }
}
