part of 'login_page_bloc.dart';

@immutable
abstract class LoginPageEvent {}

class InitLoginPageEvent extends LoginPageEvent {}

class ChangePasswordVisibilityEvent extends LoginPageEvent {
  ChangePasswordVisibilityEvent();
}
