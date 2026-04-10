import 'package:budgetloom/app_root.dart';
import 'package:budgetloom/features/auth/bloc/auth_bloc.dart';
import 'package:budgetloom/features/auth/bloc/auth_event.dart';
import 'package:budgetloom/features/auth/data/repo/auth_repository.dart';
import 'package:budgetloom/features/expense/data/repo/expense_repository.dart';
import 'package:budgetloom/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepository: AuthRepository())..add(AppStarted()),
        ),

        BlocProvider<ExpenseBloc>(
          create: (context) =>
              ExpenseBloc(expenseRepository: ExpenseRepository()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'sans-serif'),
        debugShowCheckedModeBanner: false,
        home: const AppRoot(),
      ),
    );
  }
}
