import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/service/login/login_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  LoginController({required LoginService loginService})
      : _loginService = loginService;

  final LoginService _loginService;
  final _obscurePassword = signal(true);
  bool get obscurePassword => _obscurePassword();

  void showHiddenPassword() => _obscurePassword.value = !_obscurePassword.value;

  final _logged = signal(false);
  bool get logged => _logged();

  Future<void> login(String email, String password) async {
    final result = await _loginService.execute(email, password).asyncLoader();

    switch (result) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
