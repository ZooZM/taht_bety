import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/presentation/view/signup.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_button.dart';
import 'package:taht_bety/auth/presentation/view/widgets/custom_footer.dart';
import 'package:taht_bety/auth/presentation/view/widgets/login_via_social.dart';
import 'package:taht_bety/core/utils/app_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow content to adjust when the keyboard appears
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside of TextField
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Request focus for the Email TextField
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle Forgot Password
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xff99A8C2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    },
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
                    onPressed: () {
                      context.go(AppRouter.kSingUp);
                      
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
