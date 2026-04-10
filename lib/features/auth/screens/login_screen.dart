import 'package:budgetloom/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Define controllers to capture text
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        // Navigation is handled at the root (main.dart) by the BlocBuilder,
        // so we don't need manual Navigator.push here anymore.
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Logo Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shield, color: Colors.blue[900], size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'BudgetLoom',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(flex: 1),
                  // Welcome Text
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Continue your journey into financial clarity.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  // Input Fields
                  CustomTextField(
                    hint: 'Email Address',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: 'Password',
                    isPassword: true,
                    controller: _passwordController,
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: state is AuthLoading
                              ? null // Disable button while loading
                              : () {
                                  // 5. Trigger the Event
                                  context.read<AuthBloc>().add(
                                    LoginRequested(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                },
                          icon: state is AuthLoading
                              ? const SizedBox.shrink()
                              : const Icon(
                                  Icons.lock,
                                  size: 18,
                                  color: Colors.white,
                                ),
                          label: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Secure Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10197E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Register Button
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
            child: const Text("Don't have an account? Register"),
          ),
        ),
      ),
    );
  }
}

// class CustomTextField extends StatelessWidget {
//   final String hint;
//   final bool isPassword;
//   final TextEditingController controller; // Required for capture
//
//   const CustomTextField({
//     super.key,
//     required this.hint,
//     this.isPassword = false,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
