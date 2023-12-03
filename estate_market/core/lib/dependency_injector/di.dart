import 'package:data/repositories_impl/database_repository_impl.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void diRepositories() {
  sl.registerLazySingleton<DatabaseRepository>(() => DatabaseRepositoryImpl());
}

void diUseCases() {
  sl.registerLazySingleton<DatabaseUseCase>(() => DatabaseUseCase(databaseRepository: sl.get<DatabaseRepository>()));
}
