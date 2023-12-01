part of 'register_page_bloc.dart';

enum RegisterPageType { login, signup }

class RegisterPageState extends Equatable {
  final bool isPasswordObscured;
  final bool isStayConnectedChecked;
  final RegisterPageType registerPageType;
  final PasswordStrength passwordStrenght;

  const RegisterPageState(
      {this.isPasswordObscured = true,
      this.isStayConnectedChecked = false,
      this.registerPageType = RegisterPageType.login,
      this.passwordStrenght = PasswordStrength.none});

  RegisterPageState copyWith({
    bool? isPasswordObscured,
    bool? isStayConnectedChecked,
    RegisterPageType? registerPageType,
    PasswordStrength? passwordStrenght,
  }) {
    return RegisterPageState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isStayConnectedChecked: isStayConnectedChecked ?? this.isStayConnectedChecked,
      registerPageType: registerPageType ?? this.registerPageType,
      passwordStrenght: passwordStrenght ?? this.passwordStrenght,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured, isStayConnectedChecked, registerPageType, passwordStrenght];
}
