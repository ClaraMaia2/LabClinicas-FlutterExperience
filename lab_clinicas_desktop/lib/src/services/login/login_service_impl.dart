import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/repositories/user/user_repository.dart';
import 'package:lab_clinicas_desktop/src/services/login/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServiceImpl implements LoginService {
  LoginServiceImpl({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError(message: final message)):
        return Left(
          ServiceException(message: "Error trying to log-in: $message"),
        );
      case Left(value: AuthUnauthorizedException()):
        return Left(
          ServiceException(message: "Invalid user/password"),
        );
      case Right(value: final accesToken):
        final sp = await SharedPreferences.getInstance();

        sp.setString(LocalStorageConstants.accessToken, accesToken);

        return Right(unit);
    }
  }
}
