import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_button.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_footer.dart';
import 'package:taht_bety/auth/presentation/view/widgets/login_via_social.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/data.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fetchuser();
    super.initState();
  }

  void _fetchuser() async {
    try {
      final user = await UserStorage.getUserData();
      final response = await Dio().get('$kBaseUrl/users/me',
          options: Options(headers: {'Authorization': 'Bearer ${user.token}'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        context.go(AppRouter.kHomePage);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 401) {
          UserStorage.deleteUserData();
        }
      }
    }
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await Dio().post(
          '${kBaseUrl}auth/login',
          data: {
            'email': _emailController.text,
            'password': _passwordController.text,
          },
        );

        if (!mounted) return;

        if (response.statusCode == 200 || response.statusCode == 201) {
          final userData = response.data['data'];
          UserModel user = Data.user;
          user = UserModel.fromJson(userData['user']);
          user.token = userData['token'];

          UserStorage.saveUserData(
              token: user.token!, userId: user.id!, lat: '0', long: '0');
          context.go(AppRouter.kHomePage);
        } else {
          throw Exception('Failed to sign in');
        }
      } on DioException catch (e) {
        if (!mounted) return;

        String errorMessage = 'An error occurred during sign in';
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          if (e.response!.data['error_code'] == "A4000") {
            if (mounted) {
              context.go(AppRouter.kVerify, extra: _emailController.text);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please verify your email first"),
                duration: Duration(seconds: 5),
              ),
            );
          } else {
            errorMessage = e.response!.data['message'] ?? errorMessage;
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 10),
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Hi! Welcome back, You've been missed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color(0xff99A8C2)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Sign In',
                      onPressed: _isLoading
                          ? null
                          : () {
                              _signIn();
                            },
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Or sign in with"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const LoginViaSocial(),
                    const SizedBox(height: 32),
                    CustomFooter(
                      text: "Don’t have an account?",
                      buttonText: "Sign Up",
                      onPressed: () => context.go(AppRouter.kSingUp),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
