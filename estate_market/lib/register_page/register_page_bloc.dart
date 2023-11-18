import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_page_event.dart';
part 'register_page_state.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  RegisterPageBloc() : super(const RegisterPageState()) {
    on<InitRegisterPageEvent>(_initLoginPageEventHandler);

    on<ChangePasswordVisibilityEvent>(_changePasswordVisibilityEventHandler);
    on<ChangeStayConnectedEvent>(_changeStayConnectedEventHandler);
    on<ChangeRegisterTypeEvent>(_changeRegisterTypeEventHandler);
  }

  _initLoginPageEventHandler(InitRegisterPageEvent event, Emitter<RegisterPageState> emit) {}

  _changePasswordVisibilityEventHandler(ChangePasswordVisibilityEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  _changeStayConnectedEventHandler(ChangeStayConnectedEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(isStayConnectedChecked: !state.isStayConnectedChecked));
  }

  _changeRegisterTypeEventHandler(ChangeRegisterTypeEvent event, Emitter<RegisterPageState> emit) {
    emit(state.copyWith(registerPageType: event.type));
  }
}
