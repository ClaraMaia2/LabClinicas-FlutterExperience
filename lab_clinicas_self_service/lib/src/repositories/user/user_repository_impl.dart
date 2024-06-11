import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient}); 

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log(
        "Error trying to login",
        error: e,
        stackTrace: s,
      );

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(
            AuthUnauthorizedException(),
          ),
        _ => Left(
            AuthError(message: "Error trying to login"),
          ),
      };
    }
  }
}
