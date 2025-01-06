import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_body.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/profile/presentation/service_profile.dart';
import 'package:taht_bety/user/Features/profile/presentation/user_profile.dart';

abstract class AppRouter {
  static const String kHomeBody = '/homeBody';
  static const String kServProfile = '/ServProfile';
  static const String kUserProfile = '/UserProfile';

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
    ],
  );
}
