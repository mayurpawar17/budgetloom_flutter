import 'package:budgetloom/features/transcations/data/model/all_expenses_response.dart';
import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final AllExpensesResponse allExpensesResponse;

  DataLoaded(this.allExpensesResponse);

  @override
  List<Object?> get props => [allExpensesResponse]; // BLoC will compare this list
}

class DataError extends DataState {
  final String error;

  DataError(this.error);

  @override
  List<Object?> get props => [error];
}
