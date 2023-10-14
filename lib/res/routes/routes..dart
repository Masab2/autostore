import 'package:autostore/Views/Admin/Add%20Parts/addparts.dart';
import 'package:autostore/Views/Admin/App%20Notifications/sendNotification.dart';
import 'package:autostore/Views/Admin/Auth/adminlogin.dart';
import 'package:autostore/Views/Admin/Dashboard/dasboard.dart';
import 'package:autostore/Views/Admin/Earnings/earnings.dart';
import 'package:autostore/Views/Admin/OrderInProgress/orderInprogress.dart';
import 'package:autostore/Views/Admin/Pending%20Orders/CustomerOrders.dart';
import 'package:autostore/Views/Admin/PublishedParts/publishedParts.dart';
import 'package:autostore/Views/Admin/Remove%20admin/removeadmin.dart';
import 'package:autostore/Views/Admin/user/alluser.dart';
import 'package:autostore/Views/user/CutomerOrder/MyOrder.dart';
import 'package:autostore/Views/user/Recived%20Order/recivedOrder.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:get/get.dart';
import '../../Views/Admin/Pending Orders/pendingOrder.dart';
import '../../Views/user/Cart/addtocart.dart';
import '../../Views/user/Category/categoryView.dart';
import '../../Views/user/CheckOut/userDetails.dart';
import '../../Views/user/HomeView/HomeView.dart';
import '../../Views/user/HomeView/PartsDetails/partsDetails.dart';
import '../../Views/user/IntroView/IntroScreen.dart';
import '../../Views/user/NavBar/bottomPageView.dart';
import '../../Views/user/SplashView/splashScreen.dart';
import '../../Views/user/auth/loginPageView.dart';
import '../../Views/user/auth/signUpPageView.dart';
import '../../Views/user/auth/verifyEmailAddress.dart';

class AppRoutes {
  static appRoutes() => [
        // User Routes
        GetPage(
            name: RoutesNames.splashscreen,
            page: () => const SplashScreen(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RoutesNames.introScreen,
            page: () => const IntroScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.homeScreen,
            page: () => const HomeView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.bottomScreen,
            page: () => const BottomPageView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.loginScreen,
            page: () => const LoginPageView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.signUpScreen,
            page: () => const SignUpPageView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.verifyScreen,
            page: () => const VerifyEmail(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.partsDetailScreen,
            page: () => const PartsDetails(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.cartScreen,
            page: () => const AddToCart(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.categoryScreen,
            page: () => const CategoryView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.detailsScreen,
            page: () => const UserDetails(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.myOrderScreen,
            page: () => const MyOrder(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.orderDeleveredScreen,
            page: () => const RecivedOrder(),
            transition: Transition.leftToRight),

        // Admin Routes
        GetPage(
            name: RoutesNames.adminloginScreen,
            page: () => const AdminLogin(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.admindashboardScreen,
            page: () => const AdminDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addproductScreen,
            page: () => const AddParts(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.publishedPartsScreen,
            page: () => const PublishedParts(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.alluserScreen,
            page: () => const AllUserData(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.removeadminScreen,
            page: () => const Removeadmin(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.sendNotificationScreen,
            page: () => const SendNotification(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.pendingOrdersScreen,
            page: () => const PendingOrders(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.customerOrdersScreen,
            page: () => const CustomerOrders(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.ordersInProgressScreen,
            page: () => const OrderInProgress(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.earningScreen,
            page: () => const Earnings(),
            transition: Transition.leftToRight),
      ];
}
