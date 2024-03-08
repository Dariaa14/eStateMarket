import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class ImageUploadRepository {
  Future<Either<Failure, List<String>>> uploadImages(List<String> paths);
}
