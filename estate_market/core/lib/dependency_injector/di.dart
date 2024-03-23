import 'package:data/repositories_impl/database_repository_impl.dart';
import 'package:data/repositories_impl/image_upload_repository_impl.dart';
import 'package:data/repositories_impl/register_repository_impl.dart';
import 'package:data/repositories_impl/login_repository_impl.dart';

import 'package:data/services_impl/register_service_impl.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/repositories/image_upload_repository.dart';
import 'package:domain/repositories/register_repository.dart';
import 'package:domain/repositories/login_repository.dart';

import 'package:domain/services/register_service.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/register_use_case.dart';
import 'package:domain/use_cases/login_use_case.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void diRepositories() {
  sl.registerLazySingleton<DatabaseRepository>(() => DatabaseRepositoryImpl());
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl());
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());

  sl.registerLazySingleton<ImageUploadRepository>(() => ImageUploadRepositoryImpl());

  sl.registerLazySingleton<RegisterService>(() => RegisterServiceImpl());
}

void diUseCases() {
  sl.registerLazySingleton<DatabaseUseCase>(() => DatabaseUseCase(
      databaseRepository: sl.get<DatabaseRepository>(),
      imageUploadRepository: sl.get<ImageUploadRepository>(),
      registerService: sl.get<RegisterService>()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(
      registerRepository: sl.get<RegisterRepository>(),
      registerService: sl.get<RegisterService>(),
      databaseRepository: sl.get<DatabaseRepository>()));
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl.get<LoginRepository>(), registerService: sl.get<RegisterService>()));
}
