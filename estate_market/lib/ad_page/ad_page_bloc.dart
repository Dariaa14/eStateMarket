import 'package:bloc/bloc.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:equatable/equatable.dart';

part 'ad_page_event.dart';
part 'ad_page_state.dart';

class AdPageBloc extends Bloc<AdPageEvent, AdPageState> {
  AdPageBloc() : super(const AdPageState()) {
    on<FavoritesButtonPressedEvent>(_favoritesButtonPressedEventHandler);
  }

  _favoritesButtonPressedEventHandler(FavoritesButtonPressedEvent event, Emitter<AdPageState> emit) async {
    emit(state.copyWith(favoritesChanged: !state.favoritesChanged));
  }
}
