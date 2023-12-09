import 'package:data/repositories_impl/database_repository_impl.dart';
import 'package:data/repositories_impl/register_repository_impl.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/repositories/register_repository.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/register_use_case.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void diRepositories() {
  sl.registerLazySingleton<DatabaseRepository>(() => DatabaseRepositoryImpl());
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl());
}

void diUseCases() {
  sl.registerLazySingleton<DatabaseUseCase>(() => DatabaseUseCase(databaseRepository: sl.get<DatabaseRepository>()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(registerRepository: sl.get<RegisterRepository>()));
}
