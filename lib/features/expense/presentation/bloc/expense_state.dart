import 'package:budgetloom/features/expense/data/model/category_expense_response.dart';
import 'package:budgetloom/features/expense/data/model/current_month_total_response.dart';
import 'package:budgetloom/features/transcations/data/model/newly_created_expense_response.dart';
import 'package:equatable/equatable.dart';

// abstract class ExpenseState extends Equatable {
//   const ExpenseState();
//   @override
//   List<Object?> get props => [];
// }

// class ExpenseInitial extends ExpenseState {}
//
// class ExpenseLoading extends ExpenseState {}
//
// class ExpenseLoaded extends ExpenseState {
//   final CurrentMonthTotalResponse currentMonthTotalResponse;
//   const ExpenseLoaded(this.currentMonthTotalResponse);
//   @override
//   List<Object?> get props => [currentMonthTotalResponse];
// }
//
// class CategoryAnalyticsLoaded extends ExpenseState {
//   final CategoryExpenseResponse categoryExpenseResponse;
//   const CategoryAnalyticsLoaded(this.categoryExpenseResponse);
//
//   @override
//   List<Object?> get props => [categoryExpenseResponse];
// }
//
// class ExpenseError extends ExpenseState {
//   final String message;
//   const ExpenseError(this.message);
// }

class ExpenseState extends Equatable {
  final bool isLoading;
  final CurrentMonthTotalResponse? totalResponse;
  final CategoryExpenseResponse? categoryResponse;
  final NewlyCreatedExpenseResponse? newlyCreatedExpenseResponse;
  final String? errorMessage;

  const ExpenseState({
    this.isLoading = false,
    this.totalResponse,
    this.categoryResponse,
    this.newlyCreatedExpenseResponse,
    this.errorMessage,
  });

  ExpenseState copyWith({
    bool? isLoading,
    CurrentMonthTotalResponse? totalResponse,
    CategoryExpenseResponse? categoryResponse,
    NewlyCreatedExpenseResponse? newlyCreatedExpenseResponse,
    String? errorMessage,
    bool overrideResponse = false,
  }) {
    return ExpenseState(
      isLoading: isLoading ?? this.isLoading,
      totalResponse: totalResponse ?? this.totalResponse,
      categoryResponse: categoryResponse ?? this.categoryResponse,
      // If overrideResponse is true, we take the new value even if it's null
      newlyCreatedExpenseResponse: overrideResponse
          ? newlyCreatedExpenseResponse
          : (newlyCreatedExpenseResponse ?? this.newlyCreatedExpenseResponse),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    totalResponse,
    categoryResponse,
    newlyCreatedExpenseResponse,
    errorMessage,
  ];
}
