import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();
  EditProfileBloc() : super(const EditProfileState()) {
    on<InitProfileEvent>(_initProfileEventHandler);

    on<ChangeSellerTypeEvent>(_changeSellerTypeEventHandler);
    on<ChangePhoneNumberEvent>(_changePhoneNumberEventHandler);

    on<SaveChangesEvent>(_saveChangesEventHandler);
  }

  _initProfileEventHandler(InitProfileEvent event, Emitter<EditProfileState> emit) {
    final account = _accountUseCase.currentAccount!;
    emit(state.copyWith(phoneNumber: account.phoneNumber, sellerType: account.sellerType));
  }

  _changeSellerTypeEventHandler(ChangeSellerTypeEvent event, Emitter<EditProfileState> emit) =>
      emit(state.copyWith(sellerType: event.sellerType));

  _changePhoneNumberEventHandler(ChangePhoneNumberEvent event, Emitter<EditProfileState> emit) =>
      emit(state.copyWith(phoneNumber: event.phoneNumber));

  _saveChangesEventHandler(SaveChangesEvent event, Emitter<EditProfileState> emit) =>
      _accountUseCase.updateAccount(state.phoneNumber, state.sellerType);
}
