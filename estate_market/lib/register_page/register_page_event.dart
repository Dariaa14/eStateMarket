part of 'register_page_bloc.dart';

abstract class RegisterPageEvent {}

class InitRegisterPageEvent extends RegisterPageEvent {}

class ChangePasswordVisibilityEvent extends RegisterPageEvent {
  ChangePasswordVisibilityEvent();
}

class CalculatePasswordStrenghtEvent extends RegisterPageEvent {
  String password;

  CalculatePasswordStrenghtEvent({required this.password});
}

class ChangeStayConnectedEvent extends RegisterPageEvent {
  ChangeStayConnectedEvent();
}

class ChangeRegisterTypeEvent extends RegisterPageEvent {
  RegisterPageType type;

  ChangeRegisterTypeEvent({required this.type});
}
