part of 'register_page_bloc.dart';

abstract class RegisterPageEvent {}

class ChangePasswordVisibilityEvent extends RegisterPageEvent {
  ChangePasswordVisibilityEvent();
}

class CalculatePasswordStrenghtEvent extends RegisterPageEvent {
  final String password;

  CalculatePasswordStrenghtEvent({required this.password});
}

class ChangeStayConnectedEvent extends RegisterPageEvent {
  ChangeStayConnectedEvent();
}

class ChangeRegisterTypeEvent extends RegisterPageEvent {
  RegisterPageType type;

  ChangeRegisterTypeEvent({required this.type});
}

class CreateAccountEvent extends RegisterPageEvent {
  final String email;
  final String password;

  CreateAccountEvent({required this.email, required this.password});
}

class LoginEvent extends RegisterPageEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}
