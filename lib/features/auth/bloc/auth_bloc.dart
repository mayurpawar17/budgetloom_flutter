import 'package:budgetloom/core/constants/token_manager.dart';
import 'package:budgetloom/core/utils/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    AppLogger.instance.i("AppStarted Event Received");
    emit(AuthLoading());

    try {
      final token = await TokenManager.getAccessToken();

      if (token == null) {
        emit(Unauthenticated());
        return;
      }

      // Call backend to validate token
      final user = await authRepository.getProfile(); // NEW API

      AppLogger.instance.i("Current User : ${user.email}");

      emit(Authenticated(user));
    } catch (e) {
      AppLogger.instance.e("AppStarted Error: $e");
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.instance.i("Login Requested");
    emit(AuthLoading());
    try {
      AppLogger.instance.i("Email : ${event.email}");
      final user = await authRepository.login(event.email, event.password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.instance.i("Logout Requested");
    await authRepository.logout();
    emit(Unauthenticated());
  }
}
