import 'package:budgetloom/features/transcations/bloc/transaction_event.dart';
import 'package:budgetloom/features/transcations/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/transaction_repo.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiRepository repository;

  DataBloc(this.repository) : super(DataInitial()) {
    on<LoadDataRequested>((event, emit) async {
      emit(DataLoading());
      try {
        final data = await repository.fetchData();
        print("Data Loaded: $data");
        emit(DataLoaded(data));
      } catch (e) {

        emit(DataError(e.toString()));
        print("Error: $e");
      }
    });
  }
}