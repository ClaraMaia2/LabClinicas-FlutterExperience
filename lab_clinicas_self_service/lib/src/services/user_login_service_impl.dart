import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError()):
        return Left(
          ServiceException(message: "Error: We were unabled to login"),
        );

      case Left(value: AuthUnauthorizedException()):
        return Left(
          ServiceException(message: "Invalid email or password"),
        );

      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();

        sp.setString(LocalStorageConstants.accessToken, accessToken);

        return Right(unit);
    }
  }
}
