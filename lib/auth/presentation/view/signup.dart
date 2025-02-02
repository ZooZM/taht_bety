import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_button.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_footer.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:taht_bety/auth/presentation/view/widgets/login_via_social.dart';
import 'package:taht_bety/core/utils/app_router.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A4D6F),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Fill your information below or register\nwith your social account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF99A8C2),
                ),
              ),
              const SizedBox(height: 40),
              // Name Field
              const CustomTextField(
                hintText: 'example',
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
              const SizedBox(height: 20),
              // Email Field
              const CustomTextField(
                hintText: 'example@gmail.com',
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              // Password Field

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Confirm Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  context.go(AppRouter.kVerify);
                },
              ),
              const SizedBox(height: 32),
              // Divider with "Or sign up with"
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Or sign up with",
                      style: TextStyle(color: Color(0xFF99A8C2)),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 32),
              // Social Icons
              const LoginViaSocial(),
              const SizedBox(height: 32),
              // Footer
              CustomFooter(
                text: "Already have an account?",
                buttonText: "Sign In",
                onPressed: () {
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
