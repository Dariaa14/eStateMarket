part of 'register_page_bloc.dart';

enum RegisterPageType { login, signup }

class RegisterPageState extends Equatable {
  final bool isPasswordObscured;
  final bool isStayConnectedChecked;
  final RegisterPageType registerPageType;

  const RegisterPageState(
      {this.isPasswordObscured = true,
      this.isStayConnectedChecked = false,
      this.registerPageType = RegisterPageType.login});

  RegisterPageState copyWith(
      {bool? isPasswordObscured, bool? isStayConnectedChecked, RegisterPageType? registerPageType}) {
    return RegisterPageState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isStayConnectedChecked: isStayConnectedChecked ?? this.isStayConnectedChecked,
      registerPageType: registerPageType ?? this.registerPageType,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured, isStayConnectedChecked, registerPageType];
}
