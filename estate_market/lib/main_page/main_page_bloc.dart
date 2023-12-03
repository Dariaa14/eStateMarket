import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();

  MainPageBloc() : super(MainPageInitial());

  getAdsTest() async {
    return await _databaseUseCase.getAllAds();
  }
}
