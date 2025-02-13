import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety/auth/presentation/view/signup.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_body.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/profile/presentation/service_profile.dart';
import 'package:taht_bety/user/Features/profile/presentation/user_profile.dart';

abstract class AppRouter {
  static const String kHomeBody = '/homeBody';
  static const String kHomePage = '/HomePage';
  static const String kServProfile = '/ServProfile';
  static const String kUserProfile = '/UserProfile';
  static const String kSingIn = '/SingIn';
  static const String kSingUp = '/SignUP';
  static const String kVerify = '/Verify';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
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
        path: kSingIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: kSingUp,
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        path: kVerify,
        builder: (context, state) => const VerifyCodeScreen(),
      ),
    ],
  );
}
