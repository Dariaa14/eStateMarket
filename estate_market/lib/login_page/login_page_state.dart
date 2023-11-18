part of 'login_page_bloc.dart';

class LoginPageState extends Equatable {
  final bool isPasswordObscured;

  LoginPageState({this.isPasswordObscured = true});

  LoginPageState copyWith({
    bool? isPasswordObscured,
  }) {
    return LoginPageState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured];
}
