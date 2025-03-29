import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety/auth/presentation/view/signup.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_body.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/basket.dart';
import 'package:taht_bety/user/Features/help/help_center_view.dart';
import 'package:taht_bety/user/Features/order/presentation/view/order_view.dart';
import 'package:taht_bety/user/Features/privacy/PrivacyPolicy.dart';
import 'package:taht_bety/user/Features/product/presentation/view/product_details_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/service_profile.dart';
import 'package:taht_bety/user/Features/profile/presentation/user_profile.dart';
import 'package:taht_bety/user/Features/settings/presentation/screens/notifications.dart';
import 'package:taht_bety/user/Features/settings/presentation/screens/password_manger.dart';
import 'package:taht_bety/user/Features/user_profile/presentation/your_profile.dart';

import '../../user/Features/settings/presentation/screens/settings.dart';

abstract class AppRouter {
  static const String kHomeBody = '/homeBody';
  static const String kHomePage = '/HomePage';
  static const String kServProfile = '/ServProfile';
  static const String kUserProfile = '/UserProfile';
  static const String kSingIn = '/SingIn';
  static const String kSingUp = '/SignUP';
  static const String kVerify = '/Verify';
  static const String kProductDetails = '/Product';
  static const String kBasket = '/Basket';
  static const String kOrder = '/Order';
  static const String kHelp = '/Help';
  static const String kPrivacy = '/Privacy';
  static const String kYourProfile = '/yourProfile';
  static const String kSettings = '/Settings';
  static const String kNotification = '/Notification';
  static const String kPasswordManger = '/PasswordManger';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>  const SignInScreen(),
      ),
      GoRoute(
        path: kHomePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: kServProfile,
        builder: (context, state) => const ServiceProfile(),
      ),
      GoRoute(
        path: kHomeBody,
        builder: (context, state) => const HomeBody(),
      ),
      GoRoute(
        path: kUserProfile,
        builder: (context, state) => const UserProfile(),
      ),
      GoRoute(
        path: kSingUp,
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        path: kVerify,
        builder: (context, state) => const VerifyCodeScreen(),
      ),
      GoRoute(
        path: kProductDetails,
        builder: (context, state) => const ProductDetailsWidget(),
      ),
      GoRoute(
        path: kBasket,
        builder: (context, state) => const Basket(),
      ),
      GoRoute(
        path: kOrder,
        builder: (context, state) => OrderView(),
      ),
      GoRoute(
        path: kHelp,
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: kPrivacy,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: kYourProfile,
        builder: (context, state) => const YourProfile(),
      
      ),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsScreen(),
      
      ),
      GoRoute(
        path: kPasswordManger,
        builder: (context, state) =>  PasswordMangerScreen(),
      
      ),
      GoRoute(
        path: kNotification,
        builder: (context, state) => const NotificationsScreen(),
      
      ),
   
    ],
  );
}
