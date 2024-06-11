// ignore_for_file: dead_code
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/repositories/attendant_desk/desk_assignment.dart';

class DeskAssignmentRepositoryImpl implements DeskAssignmentRepository {
  DeskAssignmentRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> startService(int deskNumber) async {
    final result = await _clearDeskByUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await restClient.auth.post(
          '/attendantDeskAssignment',
          data: {
            'user_id': '#userAuthRef',
            'desk_number': deskNumber,
            'date_created': DateTime.now().toIso8601String(),
            'status': 'Available'
          },
        );
        return Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearDeskByUser() async {
    try {
      final desk = await _getDeskByUser();

      if (desk != null) {
        await restClient.auth.delete('/attendantDeskAssignment/${desk.id}');
      }

      return Right(unit);
    } on DioException catch (e, s) {
      log(
        "Error trying to delete counter number",
        error: e,
        stackTrace: s,
      );

      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(:List data) = await restClient.auth.get(
      '/attendantDeskAssignment',
      queryParameters: {'user_id': '#userAuthRef'},
    );

    if (data
        case List(
          isNotEmpty: true,
          first: {
            'id': String id,
            'desk_number': int deskNumberDes,
          }
        )) {
      return (
        id: id,
        deskNumber: deskNumberDes,
      );
    }

    return null;
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)) = await restClient.auth.get(
          '/attendantDeskAssignment',
          queryParameters: {'user_id': '#userAuthRef'});

      return Right(data['desk_number']);
    } on DioException catch (e, s) {
      log(
        "Error trying to find counter number",
        error: e,
        stackTrace: s,
      );

      return Left(RepositoryException());
    }
  }
}
