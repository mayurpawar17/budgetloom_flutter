import 'package:budgetloom/features/expense/data/model/category_expense_response.dart';
import 'package:budgetloom/features/expense/data/model/current_month_total_response.dart';
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
  final String? errorMessage;

  const ExpenseState({
    this.isLoading = false,
    this.totalResponse,
    this.categoryResponse,
    this.errorMessage,
  });

  ExpenseState copyWith({
    bool? isLoading,
    CurrentMonthTotalResponse? totalResponse,
    CategoryExpenseResponse? categoryResponse,
    String? errorMessage,
  }) {
    return ExpenseState(
      isLoading: isLoading ?? this.isLoading,
      totalResponse: totalResponse ?? this.totalResponse,
      categoryResponse: categoryResponse ?? this.categoryResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    totalResponse,
    categoryResponse,
    errorMessage,
  ];
}
