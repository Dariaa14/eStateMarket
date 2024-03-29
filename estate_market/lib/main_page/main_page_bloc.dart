import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final LoginUseCase _loginUseCase = sl.get<LoginUseCase>();
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();

  MainPageBloc() : super(const MainPageState(ads: [])) {
    on<InitMainPageEvent>(_initMainPageEventHandler);
  }

  _initMainPageEventHandler(InitMainPageEvent event, Emitter<MainPageState> emit) async {
    await _loginUseCase.initializeCurrentToken();
    // final ads = await _databaseUseCase.getAllAds();
    // emit(state.copyWith(ads: ads));
  }

  Future<List<AdEntity>> getAdsTest() async {
    return await _databaseUseCase.getAllAds();
  }

  bool isUserLoggedIn() {
    return _accountUseCase.isUserLoggedIn();
  }
}
