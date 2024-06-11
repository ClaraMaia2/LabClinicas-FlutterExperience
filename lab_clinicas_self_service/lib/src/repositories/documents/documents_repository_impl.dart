import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/repositories/documents/documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, String>> uploadFile(
      Uint8List file, String fileName) async {
    final formData = FormData.fromMap(
      {
        "file": MultipartFile.fromBytes(file, filename: fileName),
      },
    );

    try {
      final Response(data: {'url': pathImage}) =
          await restClient.auth.post('/uploads', data: formData);

      return Right(pathImage);
    } on DioException catch (e, s) {
      log(
        "Error trying to upload file",
        error: e,
        stackTrace: s,
      );

      return Left(RepositoryException());
    }
  }
}
