import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the app first launches to check
/// if a secure token already exists in storage.
class AppStarted extends AuthEvent {}

/// Triggered when the user submits the Login form.
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Triggered when the user submits the Register form.
class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}

/// Triggered when the user clicks 'Logout'.
class LogoutRequested extends AuthEvent {}
