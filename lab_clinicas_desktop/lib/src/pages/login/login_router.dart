import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_desktop/src/pages/login/login_controller.dart';
import 'package:lab_clinicas_desktop/src/repositories/user/user_repository.dart';
import 'package:lab_clinicas_desktop/src/repositories/user/user_repository_impl.dart';
import 'package:lab_clinicas_desktop/src/services/login/login_service.dart';
import 'package:lab_clinicas_desktop/src/services/login/login_service_impl.dart';

import 'login_page.dart';

class LoginRouter extends FlutterGetItPageRouter {
  const LoginRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(
            restClient: i(),
          ),
        ),
        Bind.lazySingleton<LoginService>(
          (i) => LoginServiceImpl(
            userRepository: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => LoginController(
            loginService: i(),
          ),
        ),
      ];

  @override
  String get routeName => '/login';

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
