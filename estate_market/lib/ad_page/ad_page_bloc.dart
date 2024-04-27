import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:equatable/equatable.dart';

part 'ad_page_event.dart';
part 'ad_page_state.dart';

class AdPageBloc extends Bloc<AdPageEvent, AdPageState> {
  late MapUseCase _mapUseCase;

  AdPageBloc() : super(const AdPageState()) {
    on<InitAdPageEvent>(_initAdPageEventHandler);
  }

  _initAdPageEventHandler(InitAdPageEvent event, Emitter<AdPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();
  }
}
