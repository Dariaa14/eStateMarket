import 'package:bloc/bloc.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:equatable/equatable.dart';

part 'create_ad_event.dart';
part 'create_ad_state.dart';

class CreateAdBloc extends Bloc<CreateAdEvent, CreateAdState> {
  CreateAdBloc() : super(const CreateAdState()) {
    on<ChangeCurrentCategoryEvent>(_changeCurrentCategoryEventHandler);
  }

  _changeCurrentCategoryEventHandler(ChangeCurrentCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(currentCategory: event.category));
  }
}
