import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/service/login/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/user/user_repository.dart';

class LoginServiceImpl implements LoginService {
  LoginServiceImpl({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final resultLogin = await userRepository.login(email, password);

    switch (resultLogin) {
      case Left(value: AuthError(message: final message)):
        return Left(
          ServiceException(message: "Error trying to login: $message"),
        );
      case Left(value: AuthUnauthorizedException()):
        return Left(
          ServiceException(message: "User or password "),
        );
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();

        sp.setString(LocalStorageConstants.accessToken, accessToken);

        return Right(unit);
    }
  }
}
