import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/errors/database_errors.dart';
import 'package:domain/repositories/image_upload_repository.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class ImageUploadRepositoryImpl implements ImageUploadRepository {
  ImageUploadRepositoryImpl();

  @override
  Future<Either<Failure, List<String>>> uploadImages(List<String> paths) async {
    List<String> urls = [];
    for (final path in paths) {
      final result = await _uploadImage(path);
      if (result.isLeft()) {
        return Left((result as Left).value);
      }
      urls.add((result as Right).value);
    }
    return Right(urls);
  }

  Future<Either<Failure, String>> _uploadImage(String path) async {
    Completer<Either<Failure, String>> completer = Completer<Either<Failure, String>>();
    final request = http.MultipartRequest('POST', uploadUrl)
      ..fields['upload_preset'] = folderName
      ..fields['api_key'] = apiKey
      ..files.add(await http.MultipartFile.fromPath('file', path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonMap = json.decode(responseString);
      completer.complete(Right(jsonMap['url']));
    } else {
      completer.complete(Left(ImageUploadFailed()));
    }
    return completer.future;
  }
}
