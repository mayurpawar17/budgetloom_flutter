import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_state.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/expense/presentation/screens/home_screen.dart';
import 'features/onBoarding/presentation/screens/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomeScreen();
        }
        if (state is Unauthenticated || state is AuthFailure) {
          return const LoginScreen();
        }
        return const SplashScreen(); // Displays while AppStarted event is running
      },
    );
  }
}
