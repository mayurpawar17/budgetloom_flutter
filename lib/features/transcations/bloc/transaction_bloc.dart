import 'package:budgetloom/features/transcations/bloc/transaction_event.dart';
import 'package:budgetloom/features/transcations/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/transaction_repo.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final ApiRepository repository;

  TransactionBloc(this.repository) : super(TransactionInitial()) {
    on<LoadDataRequested>((event, emit) async {
      emit(TransactionLoading());
      try {
        final data = await repository.fetchData();
        print("Data Loaded: $data");
        emit(TransactionLoaded(data));
      } catch (e) {
        emit(TransactionError(e.toString()));
        print("Error: $e");
      }
    });
  }
}
