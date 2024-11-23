import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/profile/presentation/service_profile.dart';

abstract class AppRouter {
  static const String kHomePage = '/homePage';
  static const String kServProfile = '/ServProfile';
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
    ],
  );
}
