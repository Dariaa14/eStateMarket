import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';

import 'package:domain/repositories/register_repository.dart';
import 'package:domain/use_cases/register_use_case.dart';
import 'package:equatable/equatable.dart';

part 'register_page_event.dart';
part 'register_page_state.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  final RegisterUseCase _registerUseCase = sl.get<RegisterUseCase>();

  RegisterPageBloc() : super(const RegisterPageState()) {
    on<InitRegisterPageEvent>(_initLoginPageEventHandler);

    on<ChangePasswordVisibilityEvent>(_changePasswordVisibilityEventHandler);
    on<ChangeStayConnectedEvent>(_changeStayConnectedEventHandler);
    on<ChangeRegisterTypeEvent>(_changeRegisterTypeEventHandler);

    on<CalculatePasswordStrenghtEvent>(_calculatePasswordStrenghtEventHandler);
    on<CreateAccountEvent>(_createAccountEventHandler);

    on<SignInEvent>(_signInEventHandler);
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
    await _registerUseCase.createAccount(event.email, event.password);
  }

  _signInEventHandler(SignInEvent event, Emitter<RegisterPageState> emit) async {
    await _registerUseCase.signIn(event.email, event.password);
  }
}
