import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageState()) {
    on<InitLoginPageEvent>(_initLoginPageEventHandler);

    on<ChangePasswordVisibilityEvent>(_changePasswordVisibilityEventHandler);
  }

  _initLoginPageEventHandler(InitLoginPageEvent event, Emitter<LoginPageState> emit) {}
  _changePasswordVisibilityEventHandler(ChangePasswordVisibilityEvent event, Emitter<LoginPageState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}
