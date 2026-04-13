import 'package:budgetloom/features/transcations/data/model/all_expenses_response.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final AllExpensesResponse allExpensesResponse;

  TransactionLoaded(this.allExpensesResponse);

  @override
  List<Object?> get props => [allExpensesResponse]; // BLoC will compare this list
}

class TransactionError extends TransactionState {
  final String error;

  TransactionError(this.error);

  @override
  List<Object?> get props => [error];
}
