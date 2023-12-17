part of 'register_page_bloc.dart';

enum RegisterPageType { login, signup }

class RegisterPageState extends Equatable {
  final bool isPasswordObscured;
  final bool isStayConnectedChecked;
  final RegisterPageType registerPageType;
  final PasswordStrength passwordStrenght;

  final Failure? failure;

  const RegisterPageState(
      {this.isPasswordObscured = true,
      this.isStayConnectedChecked = false,
      this.registerPageType = RegisterPageType.login,
      this.passwordStrenght = PasswordStrength.none,
      this.failure});

  RegisterPageState copyWith({
    bool? isPasswordObscured,
    bool? isStayConnectedChecked,
    RegisterPageType? registerPageType,
    PasswordStrength? passwordStrenght,
    Failure? failure,
  }) =>
      RegisterPageState(
        isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
        isStayConnectedChecked: isStayConnectedChecked ?? this.isStayConnectedChecked,
        registerPageType: registerPageType ?? this.registerPageType,
        passwordStrenght: passwordStrenght ?? this.passwordStrenght,
        failure: failure ?? this.failure,
      );

  RegisterPageState copyWithFailureNull() => RegisterPageState(
      isPasswordObscured: isPasswordObscured,
      isStayConnectedChecked: isStayConnectedChecked,
      registerPageType: registerPageType,
      passwordStrenght: passwordStrenght,
      failure: null);

  @override
  List<Object?> get props => [isPasswordObscured, isStayConnectedChecked, registerPageType, passwordStrenght, failure];
}
