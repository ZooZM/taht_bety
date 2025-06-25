import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      _fetchUser();
    });
  }

  void _fetchUser() async {
    try {
      final user = UserStorage.getUserData();
      final dio = Dio();
      final response =
          await ApiService(dio).get(endPoint: 'users/me', token: user.token);

      if (response['success']) {
        final userData = response['data'];
        User user = User.fromJson(userData['user']);
        UserStorage.saveUserData(
          token: userData['token'],
          userId: user.id ?? '',
          name: user.name ?? '',
          email: user.email ?? '',
          photo: user.photo ?? '',
          phoneNamber: user.phoneNumber ?? '',
          lat: (user.locations != null && user.locations!.isNotEmpty)
              ? user.locations!.first.coordinates.coordinates[1].toString()
              : '0',
          long: (user.locations != null && user.locations!.isNotEmpty)
              ? user.locations!.first.coordinates.coordinates[0].toString()
              : '0',
          favProviders: user.favoriteProviders,
          address: user.locations?[0].address ?? 'unknown',
        );
        context.go(AppRouter.kHomePage);
      } else {
        context.go(AppRouter.kSingIn);
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        UserStorage.deleteUserData();
      }
      context.go(AppRouter.kSingIn);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksecondryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          ),
          child: Image.asset(
            'assets/images/taht_bety_logo.png',
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}
