import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final LoginUseCase _loginUserUseCase = sl.get<LoginUseCase>();
  ProfilePageBloc() : super(const ProfilePageState()) {}
  Future<void> logoutButtonPressed() async {
    await _loginUserUseCase.logout();
  }
}
