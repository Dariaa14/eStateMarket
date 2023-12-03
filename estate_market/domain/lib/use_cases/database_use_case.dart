import 'package:domain/repositories/database_repository.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;

  DatabaseUseCase({required DatabaseRepository databaseRepository}) : _databaseRepository = databaseRepository;

  getAllAds() async {
    return await _databaseRepository.getAllAds();
  }
}
