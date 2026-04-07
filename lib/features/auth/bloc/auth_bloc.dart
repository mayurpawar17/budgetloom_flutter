import 'package:budgetloom/features/auth/bloc/auth_event.dart';
import 'package:budgetloom/features/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
    });
    on<LogoutEvent>((event, emit) {
      emit(Unauthenticated());
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      emit(AuthInitial());
    });
  }
}
