import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final LoginUseCase _loginUseCase = sl.get<LoginUseCase>();

  MainPageBloc() : super(const MainPageState(ads: []));

  Future<List<AdEntity>> getAdsTest() async {
    return await _databaseUseCase.getAllAds();
  }

  Future<bool> isUserLoggedIn() async {
    return await _loginUseCase.isUserLoggedIn();
  }
}
