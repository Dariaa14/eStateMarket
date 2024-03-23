import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/errors/failure.dart';

import 'package:domain/repositories/register_repository.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:domain/use_cases/register_use_case.dart';
import 'package:equatable/equatable.dart';

part 'register_page_event.dart';
part 'register_page_state.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  final RegisterUseCase _registerUseCase = sl.get<RegisterUseCase>();
  final LoginUseCase _loginUseCase = sl.get<LoginUseCase>();

  RegisterPageBloc() : super(const RegisterPageState()) {
    on<InitRegisterPageEvent>(_initLoginPageEventHandler);

    on<ChangePasswordVisibilityEvent>(_changePasswordVisibilityEventHandler);
    on<ChangeStayConnectedEvent>(_changeStayConnectedEventHandler);
    on<ChangeRegisterTypeEvent>(_changeRegisterTypeEventHandler);

    on<CalculatePasswordStrenghtEvent>(_calculatePasswordStrenghtEventHandler);
    on<CreateAccountEvent>(_createAccountEventHandler);

    on<LoginEvent>(_loginEventHandler);
  }

  _initLoginPageEventHandler(InitRegisterPageEvent event, Emitter<RegisterPageState> emit) {}

  _changePasswordVisibilityEventHandler(ChangePasswordVisibilityEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  _calculatePasswordStrenghtEventHandler(CalculatePasswordStrenghtEvent event, Emitter<RegisterPageState> emit) {
    final passwordStrength = _registerUseCase.calculatePasswordStrenght(event.password);
    emit(state.copyWith(passwordStrenght: passwordStrength));
  }

  _changeStayConnectedEventHandler(ChangeStayConnectedEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(isStayConnectedChecked: !state.isStayConnectedChecked));
  }

  _changeRegisterTypeEventHandler(ChangeRegisterTypeEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(registerPageType: event.type, passwordStrenght: PasswordStrength.none));
  }

  _createAccountEventHandler(CreateAccountEvent event, Emitter<RegisterPageState> emit) async {
    final result = await _registerUseCase.addAccount({'email': event.email.trim(), 'password': event.password.trim()});
    if (result is Left) {
      final failure = (result as Left).value;
      emit(state.copyWith(failure: failure));
    } else {
      emit(state.copyWithFailureNull());
    }
  }

  _loginEventHandler(LoginEvent event, Emitter<RegisterPageState> emit) async {
    final result = await _loginUseCase.login(event.email.trim(), event.password.trim());
    if (result is Left) {
      final failure = (result as Left).value;
      emit(state.copyWith(failure: failure));
    } else {
      emit(state.copyWithFailureNull());
    }
  }
}
