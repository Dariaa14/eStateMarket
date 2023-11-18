part of 'register_page_bloc.dart';

abstract class RegisterPageEvent {}

class InitRegisterPageEvent extends RegisterPageEvent {}

class ChangePasswordVisibilityEvent extends RegisterPageEvent {
  ChangePasswordVisibilityEvent();
}

class ChangeStayConnectedEvent extends RegisterPageEvent {
  ChangeStayConnectedEvent();
}

class ChangeRegisterTypeEvent extends RegisterPageEvent {
  RegisterPageType type;

  ChangeRegisterTypeEvent({required this.type});
}
