import 'package:budgetloom/core/constants/app_logger.dart';
import 'package:budgetloom/core/constants/constant.dart';
import 'package:budgetloom/core/widgets/custom_button.dart';
import 'package:budgetloom/features/auth/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // App Name
              Text(
                "BudgetLoom",
                style: TextStyle(
                  fontSize: size.width * 0.12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // Tagline
              Text(
                "Weave your finances.\nSecure your future.",
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  height: 1.3,
                  color: Colors.grey[600],
                ),
              ),

              const Spacer(),

              // Login Button
              CustomButton(
                backgroundColor: AppColors.primaryFocusedColor,
                text: 'Login',
                onPressed: () {
                  final firebaseAuth = FirebaseAuth.instance.currentUser;
                  AppLogger.instance.d("Logged in user: ${firebaseAuth?.uid}");
                  navigateTo(context, const LoginScreen());
                },
              ),

              const SizedBox(height: 14),

              // Register Button (Outlined)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Align(alignment: Alignment.center, child: Text('or')),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google.png', height: 20),
                      const SizedBox(width: 10),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
