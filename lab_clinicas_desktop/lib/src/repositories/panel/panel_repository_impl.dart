import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'panel_repository.dart';

class PanelRepositoryImpl implements PanelRepository {
  PanelRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, String>> callOnPanel(
      String password, int attendantDesk) async {
    try {
      final Response(data: {'id': id}) = await restClient.auth.post(
        '/panelCheckIn',
        data: {
          'password': password,
          'time_called': DateTime.now().toIso8601String(),
          'attendant_desk': attendantDesk,
        },
      );

      return Right(id);
    } on DioException catch (e, s) {
      log(
        "Error trying to call patient on the panel",
        error: e,
        stackTrace: s,
      );

      return Left(RepositoryException());
    }
  }
}
