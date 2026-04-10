import 'package:equatable/equatable.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to fetch the total expenses for the current month
class GetCurrentMonthTotalEvent extends ExpenseEvent {}

class GetCategoryAnalyticsEvent extends ExpenseEvent {}

class CreateExpenseEvent extends ExpenseEvent {
  final String title;

  const CreateExpenseEvent(this.title);

  @override
  List<Object?> get props => [title];
}

/// Optional: Triggered to refresh data (useful for pull-to-refresh)
class RefreshExpensesEvent extends ExpenseEvent {}
