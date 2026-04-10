import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/expense_repository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

// class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
//   final ExpenseRepository expenseRepository;
//
//   ExpenseBloc({required this.expenseRepository}) : super(ExpenseInitial()) {
//     // Handle the Fetch event
//     on<GetCurrentMonthTotalEvent>((event, emit) async {
//       emit(ExpenseLoading());
//       try {
//         final currentMonthTotalResponse = await expenseRepository
//             .getCurrentMonthTotal();
//         emit(ExpenseLoaded(currentMonthTotalResponse));
//         // add(FetchCategoryAnalytics());
//       } catch (e) {
//         emit(ExpenseError(e.toString()));
//       }
//     });
//
//     on<GetCategoryAnalyticsEvent>((event, emit) async {
//       emit(ExpenseLoading());
//       try {
//         final analytics = await expenseRepository.getCategoryAnalytics();
//         emit(CategoryAnalyticsLoaded(analytics));
//       } catch (e) {
//         emit(ExpenseError(e.toString()));
//       }
//     });
//
//     // Handle refresh logic
//     on<RefreshExpensesEvent>((event, emit) {
//       add(GetCurrentMonthTotalEvent());
//     });
//   }
// }

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({required this.expenseRepository}) : super(const ExpenseState()) {
    on<GetCurrentMonthTotalEvent>((event, emit) async {
      AppLogger.instance.i("GetCurrentMonthTotalEvent triggered");
      // Set loading without losing existing category data
      emit(state.copyWith(isLoading: true));
      try {
        final total = await expenseRepository.getCurrentMonthTotal();
        emit(state.copyWith(isLoading: false, totalResponse: total));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<GetCategoryAnalyticsEvent>((event, emit) async {
      AppLogger.instance.i("GetCategoryAnalyticsEvent triggered");
      emit(state.copyWith(isLoading: true));
      try {
        final analytics = await expenseRepository.getCategoryAnalytics();
        // Here, we keep totalResponse and only update categoryResponse
        emit(state.copyWith(isLoading: false, categoryResponse: analytics));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<RefreshExpensesEvent>((event, emit) {
      add(GetCurrentMonthTotalEvent());
      add(GetCategoryAnalyticsEvent());
    });

    on<CreateExpenseEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await expenseRepository.createExpense(event.title);
        emit(state.copyWith(isLoading: false));

        // Crucial: Refresh data so UI updates after adding
        add(GetCurrentMonthTotalEvent());
        add(GetCategoryAnalyticsEvent());
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
