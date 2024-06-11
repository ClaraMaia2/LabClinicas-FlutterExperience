// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': access_token}) =
          await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );

      return Right(access_token);
    } on DioException catch (e, s) {
      log(
        "Error trying to login",
        error: e,
        stackTrace: s,
      );

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: "Error trying to login"))
      };
    }
  }
}
